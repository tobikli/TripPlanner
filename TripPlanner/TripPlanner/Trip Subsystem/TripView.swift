//
//  TripView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData

struct TripView: View {
    var trip: Trip
    var modelContext: ModelContext

    @State private var selectedTab: String = "Overview"

    var body: some View {
        TabView(selection: $selectedTab) {
            OverviewView(overviewViewModel: OverviewViewModel(trip: trip))
                .tabItem {
                    Image(systemName: "house")
                    Text("Overview")
                }
                .tag("Overview")
            ScheduleView(trip: trip, modelContext: modelContext)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Schedule")
                }
                .tag("Schedule")
            BudgetView(trip: trip)
                ///This is a Workaround, as TabViews inside NavigationStacks aren't working with NavigationBars
                .toolbarBackground(.visible, for: .navigationBar)
                .tabItem {
                    Image(systemName: "dollarsign")
                    Text("Budget")
                }
                .tag("Budget")
            MapView(mapViewModel: MapViewModel(trip: trip))
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag("Map")
        }
        .navigationTitle(selectedTab)
        .navigationBarTitleDisplayMode(.inline)
    }
}
