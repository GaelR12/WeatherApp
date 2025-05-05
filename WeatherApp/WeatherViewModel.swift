//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Gael Rueda on 5/5/25.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var city: String = "Springfield" // default city when first has ran
    @Published var weather: WeatherData?
    @Published var favorites: [WeatherData] = []

    func fetchWeather(for city: String) {
        WeatherAPI.shared.fetchWeather(for: city) { [weak self] data in
            self?.weather = data
        }
    }

    func addToFavorites() {
        if let weather = weather, !favorites.contains(where: { $0.name == weather.name }) {
            favorites.append(weather)
        }
        
    }
    
}

// symbols to show with diffrent locations
func symbolForWeather(_ description: String) -> String {
    let condition = description.lowercased()
    
    switch condition {
    case _ where condition.contains("clear"):
        return "sun.max.fill"
    case _ where condition.contains("cloud"):
        return "cloud.fill"
    case _ where condition.contains("rain"):
        return "cloud.rain.fill"
    case _ where condition.contains("snow"):
        return "snow"
    case _ where condition.contains("thunder"):
        return "cloud.bolt.rain.fill"
    case _ where condition.contains("mist"), _ where condition.contains("fog"):
        return "cloud.fog.fill"
    default:
        return "questionmark.circle.fill"
    }
}
