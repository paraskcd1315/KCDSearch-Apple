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
    
    func autocomplete(query: String) async throws -> [String] {
            var components = URLComponents(string: SearchApiConstants.baseURL + SearchApiConstants.autocompletePath)!
            components.queryItems = [URLQueryItem(name: "q", value: query)]

            let (data, _) = try await URLSession.shared.data(from: components.url!)

            // OpenSearch format: ["query", ["suggestion1", "suggestion2", ...]]
            let decoded = try JSONDecoder().decode([JSONValue].self, from: data)
            if decoded.count >= 2, case .array(let suggestions) = decoded[1] {
                return suggestions.compactMap { if case .string(let s) = $0 { return s } else { return nil } }
            }
            return []
        }

}
