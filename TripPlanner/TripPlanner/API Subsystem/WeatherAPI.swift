//
//  WeatherAPI.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import Foundation

///Class for interacting with the Weather API and fetch the corresponding Data
class WeatherAPI {
    ///Weather apiKey and URL for fetching Weather Data based on Location
    private let apiKey: String = "a880585761d5deda9a7f82a4fbf2e08c"
    private var baseURL: String = ""

    var weatherResponse: WeatherResponse?

    var location: String

    init(location: String) {
        self.location = location
        baseURL = "https://api.openweathermap.org/data/2.5/weather?q=\(location)&appid=a880585761d5deda9a7f82a4fbf2e08c"
    }

    /**
     Calls the fetchWeather function to handle Errors
        params: the location of where the weather should be fetched from as a String
        returns: none
        throws: none
     */
    func fetchWeatherCaller(for location: String) async {
        do {
            weatherResponse = try await fetchWeather()
        } catch {
        }
    }

    /**
     Returns the stored Latitude and Longtitude as Tuple from the WeatherResponse
         params: none
         returns: tuple of double corresponding to latitude and longtitude of the location
         throws: none
     */
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

    /**
     Returns the stored Temperature as Double from the WeatherResponse
         params: none
         returns: double of the temperature of the location
         throws: none
     */
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

    /**
     Converts the stored WeatherCondition to a String of a IconName to show in the OverView Tab
         params: none
         returns: the systemimage to the corresponding WeatherCondition as String
         throws: none
     */
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

    /**
     Fetches the Weather from the API based on the Location provided as String
         params: none
         returns: optional Weatherresponse depending if an error occurs
         throws: URLError if URLSession fails
     */
    func fetchWeather() async throws -> WeatherResponse? {
        guard let url = URL(string: baseURL) else {
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

/**
 Takes the Response of the API  in JSON format and tries to decode it to a WeatherResponse struct
     params: takes Data in jsonFormat
     returns: optional Weatherresponse depending if an error occurs
     throws: none
 */
func decodeWeatherResponse(jsonData: Data) -> WeatherResponse? {
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(WeatherResponse.self, from: jsonData)
    } catch {
        return nil
    }
}
