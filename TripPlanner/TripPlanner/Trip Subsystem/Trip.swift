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
    var events: [Event] = []
    var budget: Double
    
    init(name: String, location: String, from: Date, till: Date, budget: Double) {
        self.name = name
        self.location = location
        self.from = from
        self.till = till
        self.budget = budget
    }
    
    func getUsedAmount() -> Double {
        var used = 0.0
        for event in events {
            used += event.price
        }
        return used
    }
    
    func getUsedByCategory() -> [Category] {
        var categoriesDict: [String: Category] = [:]
        
        for event in events {
            if let existingCategory = categoriesDict[event.category] {
                let updatedCategory = Category(title: existingCategory.title, amount: existingCategory.amount + event.price)
                categoriesDict[event.category] = updatedCategory
            } else {
                let newCategory = Category(title: event.category, amount: event.price)
                categoriesDict[event.category] = newCategory
            }
        }
        
        return Array(categoriesDict.values)
    }
    
    func getBudget() -> Double {
        return budget
    }
}

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
}
