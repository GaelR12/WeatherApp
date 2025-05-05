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
                            Text("\(weather.main.temp, specifier: "%.f") °F")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

// putting data to show api call from struct
#Preview {
    let vm = WeatherViewModel() // setting vm for WeatherViewModel
    vm.favorites = [
        WeatherData(
            name: "Springfield",
            main: WeatherData.Main(temp: 72.5, humidity: 55, pressure: 1015),
            weather: [WeatherData.Weather(description: "thunder", icon: "02d")],
            wind: WeatherData.Wind(speed: 8.2)
        ),
         WeatherData(
            name: "Monett",
            main: WeatherData.Main(temp: 68.5, humidity: 65, pressure: 1010),
            weather: [WeatherData.Weather(description: "partly cloudy", icon: "04d")],
            wind: WeatherData.Wind(speed: 6.2)
         ),
        WeatherData(
            name: "Joplin",
            main: WeatherData.Main(temp: 75.5, humidity: 45, pressure: 1012),
            weather: [WeatherData.Weather(description: "snow", icon: "01d")],
            wind: WeatherData.Wind(speed: 4.2)
        )
            
    ]
    // returning view to display
    return FavoritesView()
        .environmentObject(vm)
}
