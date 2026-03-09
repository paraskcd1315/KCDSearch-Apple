//
//  SearchApiImpl.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation

struct SearchApiImpl: SearchApi {
    func search(request: SearchRequestDto) async throws -> SearchResultResponse {
        var components = URLComponents(string: SearchApiConstants.baseURL + SearchApiConstants.searchPath)!

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: request.query),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "pageno", value: "\(request.pageno)")
        ]

        if let language = request.language {
            queryItems.append(URLQueryItem(name: "language", value: language))
        }
        if let categories = request.categories {
            queryItems.append(URLQueryItem(name: "categories", value: categories))
        }
        if let engines = request.engines {
            queryItems.append(URLQueryItem(name: "engines", value: engines))
        }
        if let safesearch = request.safesearch {
            queryItems.append(URLQueryItem(name: "safesearch", value: "\(safesearch)"))
        }

        components.queryItems = queryItems

        let (data, _) = try await URLSession.shared.data(from: components.url!)
        return try JSONDecoder().decode(SearchResultResponse.self, from: data)
    }
}
