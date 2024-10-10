//
//  BudgetView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//
import SwiftUI
import SwiftData
import Charts

struct BudgetView: View {
    @Bindable var trip: Trip
    @State private var categories: [Category] = []
    @FocusState var isInputActive: Bool

    var body: some View {
        NavigationView {
            Form {
                TotalBudgetSection(budget: $trip.budget)
                UsedBudgetSection(usedAmount: trip.getUsedAmount())
                BudgetLeftSection(usedAmount: trip.getUsedAmount(), totalBudget: trip.getBudget())
                CategoriesSection(categories: categories)
                DistributionSection(categories: categories)
            }
            .navigationBarTitle("Budget")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                categories = trip.getUsedByCategory()
            }
        }
    }
}

struct TotalBudgetSection: View {
    @Binding var budget: Double
    
    var body: some View {
        Section(header: Text("Total Budget")) {
            TextField("\(budget)", value: $budget, format: .currency(code: "EUR"))
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
        }
    }
}

struct UsedBudgetSection: View {
    var usedAmount: Double
    
    var body: some View {
        Section(header: Text("Used Budget")) {
            Text(usedAmount, format: .currency(code: "EUR"))
        }
    }
}

struct BudgetLeftSection: View {
    var usedAmount: Double
    var totalBudget: Double
    
    var body: some View {
        Section(header: Text("Budget left")) {
            Text(totalBudget - usedAmount, format: .currency(code: "EUR"))
                .foregroundColor(usedAmount > totalBudget ? .red : .green)
            if totalBudget > 0.0 {
                ProgressView(value: usedAmount <= totalBudget ? usedAmount : totalBudget, total: totalBudget)
            }
        }
    }
}

struct CategoriesSection: View {
    var categories: [Category]
    
    var body: some View {
        Section(header: Text("Categories")) {
            if categories.isEmpty {
                Text("No Events yet")
            } else {
                List {
                    ForEach(categories) { category in
                        HStack {
                            Circle()
                                .fill(category.color)
                                .frame(width: 10, height: 10)
                            Text("\(category.title):")
                            Text(category.amount, format: .currency(code: "EUR"))
                        }
                    }
                }
            }
        }
    }
}

struct DistributionSection: View {
    var categories: [Category]
    
    var body: some View {
        Section(header: Text("Distribution")) {
            if categories.isEmpty {
                Text("No Events yet")
            } else {
                Chart(categories) { category in
                    SectorMark(
                        angle: .value("Amount", category.amount),
                        innerRadius: .ratio(0.6),
                        angularInset: 8
                    )
                    .foregroundStyle(category.color)
                }
                .padding()
                .frame(height: 300)
            }
        }
    }
}

#Preview {
    BudgetView(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100))
}
