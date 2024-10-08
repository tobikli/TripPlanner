//
//  Item.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import Foundation
import SwiftData

@Model
final class Trip {
    var name: String
    var location: String
    var from: Date
    var till: Date
    
    init(name: String, location: String, from: Date, till: Date) {
        self.name = name
        self.location = location
        self.from = from
        self.till = till
    }
}
