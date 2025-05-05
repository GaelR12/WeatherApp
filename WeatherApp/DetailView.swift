//
//  DetailView.swift
//  WeatherApp
//
//  Created by Gael Rueda on 5/5/25.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: WeatherData

    var body: some View {
        VStack(spacing: 20) {
            if let description = weather.weather.first?.description {
                Image(systemName: symbolForWeather(description))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            }

            Text(weather.name).font(.largeTitle)
            Text(weather.weather.first?.description.capitalized ?? "")
            Text("Temp: \(weather.main.temp, specifier: "%.1f") °F")
            Text("Humidity: \(weather.main.humidity)%")
            Text("Wind Speed: \(weather.wind.speed) mph")
            Button("Favorite") {
                viewModel.addToFavorites()
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
//    enter all the requirement values to show something as a sample
    let sample = WeatherData(
        name: "Monett",
        main: WeatherData.Main(temp: 65.2, humidity: 60, pressure: 1012),
        weather: [WeatherData.Weather(description: "clear sky", icon: "01d")],
        wind: WeatherData.Wind(speed: 5.4)
    )

    return DetailView(weather: sample)
        .environmentObject(WeatherViewModel())
}
