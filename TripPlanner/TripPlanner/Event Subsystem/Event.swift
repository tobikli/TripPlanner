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
    var price: Double
    var category: String
    
    init(name: String, location: String, date: Date, price: Double, category: String) {
        self.name = name
        self.location = location
        self.date = date
        self.price = price
        self.category = category
    }
    
}

