//
//  File.swift
//  
//
//  Created by Laksh Chakraborty on 11/28/21.
//

import Foundation

public enum ScraperError: Error, Equatable {
    case urlNotInDictionary
    case badUrl
    case networkError
    case parserError
}
