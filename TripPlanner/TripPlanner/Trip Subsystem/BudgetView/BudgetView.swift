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
                Section(header: Text("Total Budget")) {
                    TextField("\(trip.budget)", value: $trip.budget, format: .currency(code: "EUR"))
                        .submitLabel(.done)
                }
                Section(header: Text("Used Budget")) {
                    Text(trip.getUsedAmount(), format: .currency(code: "EUR"))
                }
                Section(header: Text("Budget left")) {
                    Text(trip.getBudget() - trip.getUsedAmount(), format: .currency(code: "EUR"))
                        .foregroundColor(trip.getUsedAmount() > trip.getBudget() ? .red : .green)
                    if trip.getBudget() > 0.0 {
                        ProgressView(
                            value: trip.getUsedAmount() <= trip.getBudget() ?
                            trip.getUsedAmount() : trip.getBudget(), total: trip.getBudget())
                    }
                }
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


#Preview {
    BudgetView(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100))
}
