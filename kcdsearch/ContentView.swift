//
//  ContentView.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var pendingQuery: String?

    var body: some View {
        NavigationStack {
            HomeScreen(pendingQuery: $pendingQuery)
                .navigationDestination(item: $pendingQuery) { query in
                    SearchScreen(query: query)
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(HomeViewModel())
        .environment(SearchViewModel())
}

