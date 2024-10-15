//
//  OverviewView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 09.10.24.
//

import SwiftUI
import SwiftData
import AlertToast

struct OverviewView: View {
    @State var overviewViewModel: OverviewViewModel
    @State private var editMode = false
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                TripInformationSection(trip: overviewViewModel.trip, editMode: $editMode)
                DatesSection(trip: overviewViewModel.trip, editMode: $editMode)
                WeatherSection(validWeather: overviewViewModel.validWeather,
                               location: overviewViewModel.trip.location,
                               weatherIcon: overviewViewModel.weatherIcon,
                               temperature: overviewViewModel.temperature)
                ComingUpSection(viewModel: overviewViewModel)
            }
            .navigationTitle(overviewViewModel.trip.name)
            .navigationBarTitleDisplayMode(.automatic)
            .toast(isPresenting: $showAlert, duration: 1.5) {
                AlertToast(type: .complete(.primary),
                           title: "Saved Trip")
            }
            .navigationBarItems(
                trailing: Button(action: {
                    if editMode {
                        showAlert.toggle()
                    }
                    editMode.toggle()
                }) {
                    editMode ? Text("Done") : Text("Edit")
                }
            )
        }
    }
}
