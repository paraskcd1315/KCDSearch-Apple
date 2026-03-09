//
//  SearchResultResponse.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation

struct SearchResultResponse: Codable {
    let query: String
    let results: [SearchResult]
    let answers: [String]
    let suggestions: [String]
    let numberOfResults: Int

    enum CodingKeys: String, CodingKey {
        case query, results, answers, suggestions
        case numberOfResults = "number_of_results"
    }
}
