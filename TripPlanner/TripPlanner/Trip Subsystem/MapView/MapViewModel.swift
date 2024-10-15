//
//  MapViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//


import Foundation
import SwiftData

///View Model for the MapView
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
    
    /**
        Fetches the Location of the trip through the WeatherAPI to show the correct Location on the Map
     */
    func requestLocation() async {
        let weatherAPI = WeatherAPI(location: trip.location)
        let (lat, long) = await weatherAPI.getLocation()  // Await temperature data
        latitude = lat
        longitude = long
        print(latitude, longitude)
    }
}
