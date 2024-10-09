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
    var trip: Trip
    @State private var categories: [Category] = []
    
    var body: some View {
        Form {
            Section(header: Text("Total Budget")){
                Text(trip.getBudget(), format: .currency(code: "EUR"))
            }
            Section(header: Text("Used Budget")){
                Text(trip.getUsedAmount(), format: .currency(code: "EUR"))
            }
            Section(header: Text("Budget left")){
                Text(trip.getBudget() - trip.getUsedAmount(), format: .currency(code: "EUR"))
                    .foregroundColor(trip.getUsedAmount() > trip.getBudget() ? .red : .green)
            }
            Section(header: Text("Distribution")){
                ProgressView(value: trip.getUsedAmount(), total: trip.getBudget())
                Chart(categories) { category in
                    SectorMark(
                                    angle: .value(
                                        Text(verbatim: category.title),
                                        category.amount
                                    ),
                                    innerRadius: .ratio(0.6),
                                    angularInset: 8
                                )
                                .foregroundStyle(
                                    by: .value(
                                        Text(verbatim: category.title),
                                        category.amount
                                    )
                                )
                }.padding()
                    .scaledToFit()
                    .chartLegend(.visible)
                    .chartLegend(alignment: .center)
            }
        }
        .navigationTitle("Budget")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            categories = trip.getUsedByCategory()
        }
    }
}

#Preview {
    BudgetView(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100))
}

