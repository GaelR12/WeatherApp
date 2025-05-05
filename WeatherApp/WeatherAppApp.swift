//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Gael Rueda on 5/4/25.
//

import SwiftUI
// navigation at the bottom screen
@main
struct WeatherAppApp: App {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                BrowseView()
                    .tabItem {
                        Label("Browse", systemImage: "cloud.sun")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            .environmentObject(viewModel)
        }
    }
}
