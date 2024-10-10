//
//  BudgetManager.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import Foundation
import SwiftData

@Model
class BudgetManager {
    var trip: Trip
    var budget: Double
    
    init(trip: Trip, budget: Double) {
        self.trip = trip
        self.budget = budget
    }
    
    func getUsedAmount() -> Double {
        var used = 0.0
        for event in trip.events {
            used += event.price
        }
        return used
    }
    
    func getUsedByCategory() -> [String: Double] {
        var usedByCategory: [String: Double] = [:]
        for event in trip.events {
            usedByCategory[event.category, default: 0.0] += event.price
        }
        return usedByCategory
    }
    
    func getBudget() -> Double {
        return budget
    }
}
