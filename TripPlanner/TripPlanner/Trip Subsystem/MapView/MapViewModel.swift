//
//  MapViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//


import Foundation
import SwiftData

@Observable class MapViewModel {
    var trip: Trip

    var latitude: Double = 48.1351
    var longitude: Double = 11.5820
    
    init(trip: Trip) {
        self.trip = trip
        Task {
            await requestLocation()
        }
    }
    
    func requestLocation() async {
        let weatherAPI = WeatherAPI(location: trip.location)
        let (lat, long) = await weatherAPI.getLocation()  // Await temperature data
        latitude = lat
        longitude = long
        print(latitude, longitude)
    }
}
