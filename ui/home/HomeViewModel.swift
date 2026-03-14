//
//  HomeViewModel.swift
//  kcdsearch
//
//  Created by ParasKCD on 9/3/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    private let searchService = SearchService.shared

    var query: String = "" {
        didSet {
            if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                searchService.clearSuggestions()
            } else {
                searchService.requestSuggestionsDebounced(query: query)
            }
        }
    }

    var isLoading: Bool { searchService.isLoading }
    var error: String? { searchService.error }
    var suggestions: [String] { searchService.suggestions }
    var isSuggestionsLoading: Bool { searchService.isSuggestionsLoading }

    func trimmedQuery() -> String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func clear() {
        query = ""
        searchService.clear()
    }
}
