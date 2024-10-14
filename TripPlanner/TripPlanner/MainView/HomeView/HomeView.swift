//
//  ContentView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData
import AlertToast

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showingAddTripView = false
    @State private var showToast = false
    
    var body: some View {
            NavigationStack {
                VStack {
                    if trips.isEmpty {
                        Spacer()
                        Text("No Trips yet")
                            .font(.headline)
                            .fontWeight(.light)
                            .padding(.top)
                    }
                    List {
                        TripSectionView(trips: trips, deleteAction: deleteItems, type: "Current", mC: modelContext)
                        TripSectionView(trips: trips, deleteAction: deleteItems, type: "Future", mC: modelContext)
                        TripSectionView(trips: trips, deleteAction: deleteItems, type: "Past", mC: modelContext)
                    }
                    .listRowSpacing(5)
                    .listStyle(.sidebar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: {
                                showingAddTripView.toggle()
                            }) {
                                Label("Add Trip", systemImage: "plus")
                            }
                        }
                    }
                    .navigationTitle(Text("TripPlanner"))
                    .sheet(isPresented: $showingAddTripView) {
                        AddTripView(modelContext: modelContext, showAlert: $showToast)
                    }
                    .toast(isPresenting: $showToast) {
                        AlertToast(displayMode: .banner(.slide), type: .complete(.primary), title: "Created new Trip")
                    }
                }
            }
        }
    
    ///not in ViewModel as it only deletes from the List with Animation
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Trip.self, inMemory: true)
}
