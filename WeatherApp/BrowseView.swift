//
//  BrowseView.swift
//  WeatherApp
//
//  Created by Gael Rueda on 5/5/25.
//

import Foundation
import SwiftUI

struct BrowseView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter city", text: $viewModel.city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Search") {
                    viewModel.fetchWeather(for: viewModel.city) // calling api
                }
                .padding()

                if let weather = viewModel.weather {
                    NavigationLink(destination: DetailView(weather: weather)) {
                        VStack(spacing: 10) {
                            if let description = weather.weather.first?.description {
                                Image(systemName: symbolForWeather(description))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.blue)
                            }

                            Text(weather.name)
                                .font(.title)
                            Text("\(weather.main.temp, specifier: "%.f") °F")

                        }
                        .padding()

                    }
                }

                Spacer()
            }
            .navigationTitle("Weather")
            .onAppear {
                viewModel.fetchWeather(for: viewModel.city) // looks for cities weather data
            }
        }
    }
}

#Preview {
    BrowseView()
        .environmentObject(WeatherViewModel())
}
