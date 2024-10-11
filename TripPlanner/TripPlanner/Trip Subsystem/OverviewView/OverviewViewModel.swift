//
//  OverviewViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import Foundation
import SwiftData

@Observable class OverviewViewModel {
    var trip: Trip
    
    var weatherIcon: String = "cloud.sun.fill"
    var temperature: String = "Loading..."  // Start with a loading state
    var validWeather: Bool = true
    var latitude: Double = 48.1351
    var longitude: Double = 11.5820
    
    init(trip: Trip) {
        self.trip = trip
        Task {
            await requestLocation()
            await requestWeather()
        }
    }
    
    func requestLocation() async {
        let weatherAPI = WeatherAPI(location: trip.location)
        let (lat, long) = await weatherAPI.getLocation()  // Await temperature data
        latitude = lat
        longitude = long
        print(latitude, longitude)
    }
    
    func requestWeather() async {
        let weatherAPI = WeatherAPI(location: trip.location)
        let tempDouble = await weatherAPI.getTemperature()  // Await temperature data
        let condition = weatherAPI.getWeatherCondition()  // Await temperature data
        if condition == "Unknown" && tempDouble == -1.0 {
            validWeather = false
        } else {
            weatherIcon = condition
            temperature = String(format: "%.1f", tempDouble) + " °C"
        }
    }
}
