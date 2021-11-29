import Foundation
import SwiftSoup
import SwiftyJSON

@available(macOS 10.13, *)
public class RecipeScraper {
    public static func scrape(_ urlString: String) -> Result<Recipe, ScraperError> {
        
        guard let url = URL(string: urlString) else {
            return .failure(.badUrl)
        }
        
        let contents: String
        do {
            contents = try String(contentsOf: url)
        } catch {
            return .failure(.networkError)
        }
        
        let data: Data
        do {
            let doc: Document = try SwiftSoup.parse(contents)
            let scripts: Elements = try doc.getElementsByAttributeValue("type", "application/ld+json")
            var scriptString: String = ""
            
            for element in scripts {
                if element.data().lowercased().contains("\"@type\":\"recipe\"") || element.data().lowercased().contains("\"@type\": \"recipe\"") {
                    scriptString = element.data()
                }
            }
            
            data = scriptString.data(using: .utf8)!
        } catch {
            return .failure(.parserError)
        }
        
        var json: JSON
        do {
            json = try JSON(data: data)
        } catch {
            return .failure(.parserError)
        }
        
        for (_, subJson):(String, JSON) in json {
            if let test = subJson["@type"].string {
                if test.lowercased() == "recipe" {
                    json = subJson
                    break
                }
            }
        }
        
        let title: String? = json["name"].string
        let prepTime: Int? = Utils.getMinutes(json["prepTime"].string)
        let cookTime: Int? = Utils.getMinutes(json["cookTime"].string)
        let totalTime: Int? = Utils.getMinutes(json["totalTime"].string)
        let yield: String? = json["recipeYield"].string
        
        let recipe = Recipe(title: title, prepTime: prepTime, cookTime: cookTime, totalTime: totalTime, yield: yield, image: nil, ingredients: [], instructionGroups: [])
        
        return .success(recipe)
    }
}
