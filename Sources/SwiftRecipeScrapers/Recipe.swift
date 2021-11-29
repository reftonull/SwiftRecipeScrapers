//
//  Recipe.swift
//  
//
//  Created by Laksh Chakraborty on 11/28/21.
//

import Foundation
import SwiftyJSON

public struct Recipe {
    public let title: String?
    public let prepTime: Int?
    public let cookTime: Int?
    public let totalTime: Int?
    public let yield: String?
    public let image: String?
    public let ingredients: [String]
    public let instructionGroups: [RecipeInstructionGroup]
}

public struct RecipeInstructionGroup {
    public let title: String?
    public var instructions: [String]
}

extension Recipe: CustomStringConvertible {
    public var description: String {
        return "Title: \(title ?? "Unknown Title") \n" +
            "Prep Time: \(prepTime ?? -1) \n" +
            "Cook Time: \(cookTime ?? -1) \n" +
            "Total Time: \(totalTime ?? -1) \n" +
            "Yield: \(yield ?? "Unknown yield") \n" +
            "Image: \(image ?? "Unknown image") \n" +
            "Ingredients: \(ingredients) \n" +
            "Instructions: \(instructionGroups.description) \n"
    }
    
    public init() {
        title = nil
        prepTime = nil
        cookTime = nil
        totalTime = nil
        yield = nil
        image = nil
        ingredients = []
        instructionGroups = []
    }
}

extension Recipe: Equatable {
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.title == rhs.title
    }
}
