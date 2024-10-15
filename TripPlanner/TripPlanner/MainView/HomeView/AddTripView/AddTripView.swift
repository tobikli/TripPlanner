//
//  AddTripView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import SwiftData

struct AddTripView: View {
    @Environment(\.dismiss) private var dismiss

    var modelContext: ModelContext

    @Binding var showAlert: Bool

    @State var viewModel: AddTripViewModel

    init(modelContext: ModelContext, showAlert: Binding<Bool>) {
        self.modelContext = modelContext
        self._viewModel = State(wrappedValue: AddTripViewModel(modelContext: modelContext))
        self._showAlert = showAlert
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Information")) {
                    TextField("Trip Name", text: $viewModel.name)
                    TextField("Location", text: $viewModel.location)
                }
                Section(header: Text("Time")) {
                    DatePicker("From", selection: $viewModel.from, displayedComponents: .date)
                    DatePicker("Until", selection: $viewModel.till, displayedComponents: .date)
                }
                Section(header: Text("Budget")) {
                    TextField("Initial Budget",
                              value: $viewModel.budget,
                              format: .currency(code: "EUR")).submitLabel(.done)
                }
            }
            .navigationTitle("Create New Trip")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        viewModel.addTrip()
                        showAlert.toggle()
                        dismiss()
                    }
                }
            }
        }
    }
}
