//
//  AddEventView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import SwiftData

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: AddEventViewModel
    
    var modelContext: ModelContext

    var trip: Trip
    
    init(modelContext: ModelContext, trip: Trip) {
        self.modelContext = modelContext
        self.trip = trip
        self._viewModel = State(wrappedValue: AddEventViewModel(modelContext: modelContext, trip: trip))
    }


    var body: some View {
            NavigationView {
                Form {
                    CategoryPicker(category: $viewModel.category)
                    if viewModel.category == "Flight" {
                        Section(header: Text("Flight Information")) {
                            TextField("Flight Number", text: Binding(
                                get: { viewModel.flightNumber ?? "" },
                                set: { viewModel.flightNumber = $0.isEmpty ? nil : $0 }
                            ))
                        }
                    }
                    InformationSection(name: $viewModel.name, location: $viewModel.location)
                    TimeSection(date: $viewModel.date)
                    PriceSection(cost: $viewModel.cost)
                }
                .navigationTitle("Create New Event")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Create") {
                            viewModel.addItem()
                            dismiss()
                        }
                    }
                }
            }
        }
   
    
    struct CategoryPicker: View {
        @Binding var category: String
        
        var body: some View {
            Picker("Event Category", selection: $category) {
                Text("Flight").tag("Flight")
                Text("Accommodation").tag("Accommodation")
                Text("Transportation").tag("Transportation")
                Text("Food").tag("Food")
                Text("Activity").tag("Activity")
            }
            .pickerStyle(.inline)
        }
    }

    struct InformationSection: View {
        @Binding var name: String
        @Binding var location: String
        
        var body: some View {
            Section(header: Text("Information")) {
                TextField("Event Name", text: $name)
                TextField("Location", text: $location)
            }
        }
    }

    struct TimeSection: View {
        @Binding var date: Date
        
        var body: some View {
            Section(header: Text("Time")) {
                DatePicker("Date", selection: $date)
            }
        }
    }

    struct PriceSection: View {
        @Binding var cost: Double
        
        var body: some View {
            Section(header: Text("Price")) {
                TextField("Price", value: $cost, format: .currency(code: "EUR"))
                    .keyboardType(.decimalPad)
            }
        }
    }
}
