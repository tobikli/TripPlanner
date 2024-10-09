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
    var from: Date
    var till: Date
    var price: Double?
    
    init(name: String, location: String, from: Date, till: Date) {
        self.name = name
        self.location = location
        self.from = from
        self.till = till
    }
}
