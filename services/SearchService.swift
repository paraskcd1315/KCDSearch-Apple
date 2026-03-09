//
//  Search Service.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class SearchService {
    static let shared = SearchService()

    private let searchRepository = SearchRepository()

    private(set) var results: [SearchResult] = []
    private(set) var isLoading = false
    
    private(set) var error: String? = nil
    private(set) var currentPage = 1
    private(set) var hasMorePages = true
    private(set) var totalResults = 0

    private init() {}

    func search(request: SearchRequestDto) async {
        isLoading = true
        error = nil
        currentPage = 1
        results = []

        let result = await searchRepository.search(request: request)

        switch result {
        case .success(let response):
            results = response.results
            totalResults = response.numberOfResults
            hasMorePages = !response.results.isEmpty
        case .failure(let err):
            error = err.localizedDescription
        }

        isLoading = false
    }

    func loadNextPage(query: String) async {
        guard hasMorePages && !isLoading else { return }
        isLoading = true

        let result = await searchRepository.search(
            request: SearchRequestDto(query: query, pageno: currentPage + 1)
        )

        switch result {
        case .success(let response):
            results += response.results
            hasMorePages = !response.results.isEmpty
            currentPage += 1
        case .failure(let err):
            error = err.localizedDescription
        }

        isLoading = false
    }

    func clear() {
        results = []
        error = nil
        currentPage = 1
        hasMorePages = true
        totalResults = 0
    }
}
