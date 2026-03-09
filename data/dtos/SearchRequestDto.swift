//
//  SearchResultDto.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation

struct SearchRequestDto {
    let query: String
    let pageno: Int
    let language: String?
    let categories: String?
    let engines: String?
    let safesearch: Int?

    init(
        query: String,
        pageno: Int = 1,
        language: String? = nil,
        categories: String? = nil,
        engines: String? = nil,
        safesearch: Int? = nil
    ) {
        self.query = query
        self.pageno = pageno
        self.language = language
        self.categories = categories
        self.engines = engines
        self.safesearch = safesearch
    }
}
