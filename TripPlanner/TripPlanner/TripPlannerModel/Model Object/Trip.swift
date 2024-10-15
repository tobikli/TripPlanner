//
//  Item.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import Foundation
import SwiftData
import SwiftUI

///Model for a trip
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
    
    /**
     returns the summed up amount of all event costs of the given trip
     */
    func getUsedAmount() -> Double {
        var used = 0.0
        for event in events {
            used += event.cost
        }
        return used
    }
    
    /**
     returns an array of all used categories of the trip including the total cost of this category
     */
    func getUsedByCategory() -> [Category] {
        var categoriesDict: [String: Category] = [:]
        
        for event in events {
            if let existingCategory = categoriesDict[event.category] {
                let updatedCategory = Category(
                    title: existingCategory.title,
                    amount: existingCategory.amount + event.cost,
                    color: existingCategory.color)
                categoriesDict[event.category] = updatedCategory
            } else {
                let newCategory = Category(
                    title: event.category,
                    amount: event.cost,
                    color: matchColor(category: event.category))
                categoriesDict[event.category] = newCategory
            }
        }
        
        return Array(categoriesDict.values)
    }
    
    /**
     returns the defined budget of the trip
     */
    func getBudget() -> Double {
        return budget
    }
    
    /**
     matches the category name to the fitting color for graph representation
     */
    func matchColor(category: String) -> Color {
        switch category {
        case "Flight": return .red
        case "Accommodation": return .blue
        case "Transportation": return .green
        case "Food": return .yellow
        case "Activity": return .purple
        default: return .black
        }
    }
}

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let color: Color
}
