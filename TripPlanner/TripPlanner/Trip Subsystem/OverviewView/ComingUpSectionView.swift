//
//  ComingUpSectionView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI

struct ComingUpSection: View {
    var viewModel: OverviewViewModel

    var body: some View {
        Section(header: Text("Coming Up")) {
            if let firstEvent = viewModel.getFirstEvent() {
                NavigationLink {
                    EventDetailView(event: firstEvent)
                } label: {
                    EventBox(event: firstEvent)
                }
            } else {
                Text("No upcoming Events")
            }
        }
    }
}
