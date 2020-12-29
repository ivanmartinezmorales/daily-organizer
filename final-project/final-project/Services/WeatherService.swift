//
//  WeatherService.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import Foundation
import MapKit
import Combine

/**
 WeatherApiUrl Builds a URL in the following format:
 https:// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
 */
class WeatherService {
    let decoder = JSONDecoder()
    let session: URLSession
    

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias WeatherCompletionHandler = (Weather?, Error?) -> Void

    func getWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        
//        guard let url = WeatherApiUrl()
//                .withLat(value: coordinate.latitude)
//                .withLon(value: coordinate.longitude)
//                .build() else {
//            return
//        }
        print(coordinate)
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=55634e73b45d00626ee8a4a0074d83a9&units=imperial") else { return }
        
        print(url)
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, "Request failed" as? Error)
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try? self.decoder.decode(Weather.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, "Invalid data" as? Error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    private final class WeatherApiUrl {
        fileprivate let apiKey: String = "55634e73b45d00626ee8a4a0074d83a9"
        
        private var components: URLComponents
        
        init() {
            self.components = URLComponents()
            self.components.scheme = "https"
            self.components.host = "api.openweathermap.org"
            self.components.path = "data/2.5/weather"
            self.components.queryItems = []
        }
        
        
        func withLat(value: Double) -> WeatherApiUrl {
            self.components.queryItems?.append(URLQueryItem(name: "lat", value: String(value)))
            return self
        }
        
        func withLon(value: Double) -> WeatherApiUrl {
            self.components.queryItems?.append(URLQueryItem(name: "lon", value: String(value)))
            return self
        }

        func build() -> URL? {
            self.components.queryItems?.append(URLQueryItem(name: "appid", value: self.apiKey))
            self.components.queryItems?.append(URLQueryItem(name: "units", value: "imperial"))
            
            return self.components.url
        }
    }
}

