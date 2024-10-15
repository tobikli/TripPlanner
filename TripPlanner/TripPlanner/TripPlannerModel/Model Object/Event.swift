//
//  Event.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import Foundation
import SwiftData

///Model for an Event
@Model
final class Event {
    var name: String
    var location: String
    var from: Date
    var until: Date
    var cost: Double
    var category: String
    var flightNumber: String
    
    init(
        name: String,
        location: String,
        from: Date,
        until: Date,
        cost: Double,
        category: String,
        flightNumber: String
    ) {
        self.name = name
        self.location = location
        self.from = from
        self.until = until
        self.cost = cost
        self.category = category
        self.flightNumber = flightNumber
    }
}
