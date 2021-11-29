import XCTest
@testable import SwiftRecipeScrapers

final class SwiftRecipeScrapersTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let result = RecipeScraper.scrape("https://www.allrecipes.com/recipe/274860/grilled-balsamic-chicken-breast/")
        XCTAssertEqual(result, .failure(.networkError))
        switch result {
        case .success(let recipe):
            print(recipe)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
