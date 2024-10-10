//
//  TripSection.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import Foundation
import SwiftUI
import SwiftData


struct  TripSectionView: View {
    let deleteAction: (IndexSet) -> Void
    let type: String
    
    var modelContext: ModelContext

    @State var viewModel: TripSectionViewModel
    
    init(trips: [Trip], deleteAction: @escaping (IndexSet) -> Void, type: String, mC: ModelContext) {
        self.modelContext = mC
        self.deleteAction = deleteAction
        self.type = type
        self._viewModel = State(
            wrappedValue: TripSectionViewModel(trips: trips,
                                               deleteAction: deleteAction,
                                               type: type,
                                               modelContext: modelContext))
    }

    var body: some View {
        Section(header: Text("\(viewModel.type) Trips")) {
            ForEach(viewModel.getTrips()) { trip in
                    NavigationLink {
                        TripView(trip: trip, modelContext: modelContext)
                    } label: {
                        TripBox(trip: trip)
                    }
            }
            .onDelete(perform: viewModel.deleteAction)
        }
    }
}
