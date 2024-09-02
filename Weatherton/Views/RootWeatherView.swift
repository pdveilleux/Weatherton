//
//  RootWeatherView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import SwiftUI

struct RootWeatherView: View {
    @State var viewModel: ViewModel
    @EnvironmentObject var dependencyJar: DependencyJar

    var body: some View {
        ZStack {
            VStack {
                if let message = viewModel.errorMessage {
                    MessageView(message: message)
                        .frame(maxWidth: .infinity)
                }

                if viewModel.isSearching {
                    List(viewModel.locationResults, id: \.self) { location in
                        Button {
                            viewModel.isSearching = false
                            Task {
                                await viewModel.addLocation(location)
                            }
                        } label: {
                            Text(Strings.locationName(name: location.name, region: location.region))
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.weatherData, id: \.self) { weather in
                            Button {
                                viewModel.weatherDetailItem = weather.backingData
                            } label: {
                                weatherRow(weather)
                            }
                            .tint(.primary)
                            .listRowSeparator(.hidden)
                            .accessibilityLabel(Strings.locationAccessibilityLabel(
                                location: weather.location.name,
                                temperature: weather.apparentTemperature,
                                description: weather.description
                            ))
                            .accessibilityElement(children: .combine)
                            .accessibilityIdentifier("Location: \(weather.location.name)")
                        }
                        .onDelete(perform: delete)
                    }
                    .listStyle(.plain)
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .accessibilityIdentifier("RootWeatherView")
        .navigationTitle(Strings.currentWeatherHeader)
        .searchable(
            text: Binding(
                get: { viewModel.searchText.value },
                set: { viewModel.searchText.send($0) }),
            isPresented: $viewModel.isSearching
        )
        .refreshable {
            Task {
                await viewModel.getWeatherData()
            }
        }
        .fullScreenCover(item: $viewModel.weatherDetailItem) { weather in
            NavigationStack {
                WeatherDetailView(
                    viewModel: dependencyJar.viewModelFactory.buildWeatherDetailViewModel(currentWeather: weather)
                )
            }
        }
        .task {
            await viewModel.getWeatherData()
        }
    }

    @ViewBuilder
    private func weatherRow(_ weather: FormattedCurrentWeather) -> some View {
        VStack(alignment: .leading) {
            if let icon = weather.systemImage {
                Image(systemName: icon)
                    .font(.title)
            }
            Text(weather.apparentTemperature)
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Text(weather.location.name)
                .font(.subheadline)
                .fontDesign(.rounded)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Design.Spacing.small)
        .background(LinearGradient(gradient: weather.temperatureGradient, startPoint: .leading, endPoint: .trailing))
        .clipShape(Design.ClipShape.standardRoundedRectangle)
    }

    @MainActor func delete(at offsets: IndexSet) {
        viewModel.removeLocations(at: offsets)
    }
}

#Preview {
    NavigationStack {
        RootWeatherView(
            viewModel: RootWeatherView.ViewModel(
                weatherRepository: PreviewWeatherRepository(),
                preferenceManager: DefaultPreferenceManager(),
                temperatureFormatter: PreviewData.Formatter.temperature, 
                logger: PreviewData.Logging.logger
            )
        )
    }
}
