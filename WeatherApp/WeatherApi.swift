//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Gael Rueda on 5/4/25.
//

import Foundation

struct WeatherData: Codable, Identifiable {
    var id: UUID { UUID() }
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind

    struct Main: Codable {
        let temp: Double
        let humidity: Int
        let pressure: Int
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Wind: Codable {
        let speed: Double
    }
}

class WeatherAPI {
    static let shared = WeatherAPI()
    private let apiKey = "cc84d0f211330128f0bf0c8c5bc56c20" 

    func fetchWeather(for city: String, completion: @escaping (WeatherData?) -> Void) {
        let query = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(query)&appid=\(apiKey)&units=imperial"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(WeatherData.self, from: data) {
                    DispatchQueue.main.async {
                        completion(decoded)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
