//
//  SearchViewModel.swift
//  kcdsearch
//
//  Created by ParasKCD on 9/3/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class SearchViewModel {
    private let searchService = SearchService.shared

    var results: [SearchResult] { searchService.results }
    var isLoading: Bool { searchService.isLoading }
    var error: String? { searchService.error }
    var hasMorePages: Bool { searchService.hasMorePages }
    var totalResults: Int { searchService.totalResults }

    func search(query: String) async {
        await searchService.search(request: SearchRequestDto(query: query))
    }

    func loadNextPage(query: String) async {
        await searchService.loadNextPage(query: query)
    }
}
