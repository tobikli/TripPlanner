//
//  Event.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import Foundation
import SwiftData

@Model
final class Event {
    var name: String
    var location: String
    var date: Date
    var cost: Double
    var category: String
    var flightNumber: String?
    
    init(name: String, location: String, date: Date, cost: Double, category: String, flightNumber: String?) {
        self.name = name
        self.location = location
        self.date = date
        self.cost = cost
        self.category = category
        self.flightNumber = flightNumber
    }
}
