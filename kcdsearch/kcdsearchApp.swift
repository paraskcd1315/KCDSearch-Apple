//
//  kcdsearchApp.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import SwiftUI

@main
struct kcdsearchApp: App {
    @State private var homeViewModel = HomeViewModel()
    @State private var searchViewModel = SearchViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(homeViewModel)
                .environment(searchViewModel)
        }
    }
}
