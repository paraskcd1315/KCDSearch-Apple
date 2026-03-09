//
//  SearchResult.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation

struct SearchResult: Codable, Identifiable {
    let url: String?
    let title: String?
    let thumbnail: String?
    let content: String?
    let engine: String?
    let score: Double?
    let category: String?
    let template: String?

    var id: String { url ?? UUID().uuidString }

    enum CodingKeys: String, CodingKey {
        case url, title, thumbnail, content, engine, score, category, template
    }
}
