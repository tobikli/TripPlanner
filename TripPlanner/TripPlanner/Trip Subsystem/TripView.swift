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
    
    var body: some View {
        TabView {
            OverviewView(overviewViewModel: OverviewViewModel(trip: trip))
                .tabItem {
                    Image(systemName: "house")
                    Text("Overview")
                }
            ScheduleView(trip: trip)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Schedule")
                }
            BudgetView(trip: trip)
                .tabItem {
                    Image(systemName: "dollarsign")
                    Text("Budget")
                }
        }
    }
}


#Preview {
    TripView(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100))
}
