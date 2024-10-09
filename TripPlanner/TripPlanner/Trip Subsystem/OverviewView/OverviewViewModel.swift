//
//  OverviewViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import Foundation
import SwiftData

class OverviewViewModel: ObservableObject {
    
    @Published var trip: Trip
    
    var weatherIcon: String = "cloud.sun.fill"
    var temperature: String = "30 °C"
    var validWeather: Bool = true
    
    init(trip: Trip) {
        self.trip = trip
        requestWeather()
    }
    
    func requestWeather() {
        let response = WeatherAPI().fetchWeatherCaller(for: trip.location)
    }
    
    func formattedTripDates() -> (from: String, till: String) {
        let fromDate = trip.from.formatted(.dateTime.month().day().year())
        let tillDate = trip.till.formatted(.dateTime.month().day().year())
        return (fromDate, tillDate)
    }
    
    
}
