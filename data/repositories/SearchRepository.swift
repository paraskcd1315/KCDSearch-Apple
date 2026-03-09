//
//  SearchRepository.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation

class SearchRepository {
    private let searchApi: SearchApi

    init(searchApi: SearchApi = SearchApiImpl()) {
        self.searchApi = searchApi
    }

    func search(request: SearchRequestDto) async -> Result<SearchResultResponse, Error> {
        do {
            let response = try await searchApi.search(request: request)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
