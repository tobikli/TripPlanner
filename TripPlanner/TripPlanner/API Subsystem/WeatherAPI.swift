//
//  WeatherAPI.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import Foundation


class WeatherAPI {
    ///Weather apiKey and URL for fetching Weather Data based on Location
    private let apiKey: String = "a880585761d5deda9a7f82a4fbf2e08c"
    private let baseURL1: String = "https://api.openweathermap.org/data/2.5/weather?q="
    private let baseURL2: String = "&appid=a880585761d5deda9a7f82a4fbf2e08c"
    
    var location: String
    var weatherResponse: WeatherResponse?
    
    init(location: String) {
            self.location = location
        }
    
    func fetchWeatherCaller(for location: String) async {
        do {
            weatherResponse = try await fetchWeather(for: location)
        } catch {
        }
    }
    
    func getLocation() async -> (Double, Double) {
        if let real = weatherResponse {
            return (real.coord.lat, real.coord.lon)
        } else {
            await fetchWeatherCaller(for: location)
            if let real = weatherResponse {
                return (real.coord.lat, real.coord.lon)
            } else {
                return (48.1351, 11.5820)
            }
        }
    }
    
    func getTemperature() async -> Double {
        if let real = weatherResponse {
            return real.main.temp - 273.15
        } else {
            await fetchWeatherCaller(for: location)
            if let real = weatherResponse {
                return real.main.temp - 273.15
            } else {
                return -1.0
            }
        }
    }
    
    func getWeatherCondition() -> String {
        guard let weather = weatherResponse?.weather.first else {
            return "Unknown"
        }
        switch weather.main.lowercased() {
        case "clear":
            return "sun.max"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain"
        case "snow":
            return "cloud.snow"
        default:
            return "Unknown"
        }
    }
    
    ///Takes location as string and returns temperature, state, and validity
    func fetchWeather(for location: String) async throws -> WeatherResponse? {
        guard let url = URL(string: baseURL1 + location + baseURL2) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let ret = decodeWeatherResponse(jsonData: data)
        return ret
    }
}

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Weather
struct Weather: Codable {
    let main: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

func decodeWeatherResponse(jsonData: Data) -> WeatherResponse? {
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(WeatherResponse.self, from: jsonData)
    } catch {
        return nil
    }
}
