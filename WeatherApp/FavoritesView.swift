//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by Gael Rueda on 5/5/25.
//

import Foundation
import SwiftUI


struct FavoritesView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.favorites) { weather in
                NavigationLink(destination: DetailView(weather: weather)) {
                    HStack(spacing: 12) {
                        if let description = weather.weather.first?.description {
                            Image(systemName: symbolForWeather(description))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.blue)
                        }

                        VStack(alignment: .leading) {
                            Text(weather.name).bold()
                            Text("\(weather.main.temp, specifier: "%.1f") °F")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}


#Preview {
    let vm = WeatherViewModel()
    vm.favorites = [
        WeatherData(
            name: "Springfield",
            main: WeatherData.Main(temp: 72.5, humidity: 55, pressure: 1015),
            weather: [WeatherData.Weather(description: "cloudy", icon: "02d")],
            wind: WeatherData.Wind(speed: 8.2)
        )
    ]
    
    return FavoritesView()
        .environmentObject(vm)
}
