//
//  WeatherViewModel.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import Foundation

struct WeatherViewModel {
    let time: String
    let description: String
    let icon: String
    let temperature: String
    let windSpeed: String
    let humidity: String
    
    init() {
        self.time = "--"
        self.description = "Unavailable"
        self.icon = "questionmark.circle"
        self.temperature = "--"
        self.windSpeed = "--"
        self.humidity = "--"
    }
    
    init(weather: Weather) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        self.time = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
        
        self.description = weather.weather.first!.weatherDescription
        self.icon = "sun.max.fill"
        self.temperature = String(weather.main.temp)
        self.windSpeed = String(weather.wind.speed)
        self.humidity = "\(String(weather.main.humidity))%"
    }
}
