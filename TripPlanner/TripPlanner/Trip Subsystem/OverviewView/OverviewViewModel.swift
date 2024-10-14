//
//  OverviewViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import Foundation
import SwiftData
import UIKit
import os

@Observable class OverviewViewModel {
    var trip: Trip
    var logger: Logger
    
    var weatherIcon: String = "cloud.sun.fill"
    var temperature: String = "Loading..."  // Start with a loading state
    var validWeather: Bool = true
    var latitude: Double = 48.1351
    var longitude: Double = 11.5820
    
    init(trip: Trip) {
        self.trip = trip
        self.logger = Logger()
        Task {
            await requestWeather()
        }
    }
    
    /**
        Fetches the WeatherData from the WeatherAPI to display them on the Overview
     */
    func requestWeather() async {
        let weatherAPI = WeatherAPI(location: trip.location)
        let tempDouble = await weatherAPI.getTemperature()
        let condition = weatherAPI.getWeatherCondition()
        logger.info("Decoded temperature: \(tempDouble)")
        logger.info("Decoded condition: \(condition)")
        if condition == "Unknown" && tempDouble == -1.0 {
            validWeather = false
        } else {
            weatherIcon = condition
            temperature = String(format: "%.1f", tempDouble) + " °C"
        }
    }
    
    /**
        Gets the first schedule of the Trip to show it on the Overview for convenience
     */
    func getFirstEvent() -> Event? {
        if trip.events.isEmpty {
            return nil
        } else {
            return trip.events.sorted(by: { $0.date < $1.date })[0]
        }
    }
}
