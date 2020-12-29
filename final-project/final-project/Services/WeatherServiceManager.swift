//
//  WeatherServiceManager.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//


import SwiftUI
import Combine

class WeatherServiceManager: ObservableObject {
    
    @ObservedObject var locationManager = LocationManager()
    @Published var weather: Weather? = nil

    let client = WeatherService()
    

    init() {
        print(locationManager.location)
        // Get the user's current location
        // then take the current location, reverse geocode it and get the weather for that location
        client.getWeather(at: Coordinate(latitude: locationManager.location?.latitude ?? 0, longitude: locationManager.location?.longitude ?? 0)) { weather, error in
            if let weather = weather {
                print(weather)
                self.weather = weather
            } 
        }
    }
}
