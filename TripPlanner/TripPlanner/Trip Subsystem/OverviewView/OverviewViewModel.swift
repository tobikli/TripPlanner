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
    var temperature: String = "30 °C"
    var validWeather: Bool = true
    
    init(trip: Trip) {
        self.trip = trip
        requestWeather()
    }
    
    func requestWeather() {
        //let response = WeatherAPI().fetchWeatherCaller(for: trip.location)
    }
}
