//
//  ContentView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showingAddItemView = false
    
    var body: some View {
            NavigationView {
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
                    .listStyle(.sidebar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: {
                                showingAddItemView.toggle()
                            }) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    .navigationTitle(Text("TripPlanner"))
                    .sheet(isPresented: $showingAddItemView) {
                        AddTripView(modelContext: modelContext)
                    }
                    .listStyle(.grouped)
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
