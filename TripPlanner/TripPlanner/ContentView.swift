//
//  ContentView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 08.10.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showingAddItemView = false

    var body: some View {
        NavigationSplitView {
            VStack {
                if trips.isEmpty {
                    Spacer()
                    Text("No Trips yet")
                        .font(.title)  // Customize font size, style, etc.
                        .fontWeight(.light)  // Bold text for emphasis
                    .padding(.top)}
                List {
                    Section(header: Text("Current Trips")){
                        ForEach(trips) { trip in
                            if(trip.from <= Date() && trip.till >= Date()){
                                NavigationLink {
                                    Text("\(trip.name)")
                                } label: {
                                    ExtractedView(trip: trip)
                                }
                            }
                        } .onDelete(perform: deleteItems)
                    }
                    Section(header: Text("Future Trips")){
                        ForEach(trips) { trip in
                            if(trip.from > Date()){
                                NavigationLink {
                                    Text("\(trip.name)")
                                } label: {
                                    ExtractedView(trip: trip)
                                }
                            }
                        } .onDelete(perform: deleteItems)
                    }
                    Section(header: Text("Past Trips")){
                        ForEach(trips) { trip in
                            if(trip.till < Date()){
                                NavigationLink {
                                    Text("\(trip.name)")
                                } label: {
                                    ExtractedView(trip: trip)
                                }
                            }
                        } .onDelete(perform: deleteItems)
                    }
                }
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
                                    AddItemView()
                                }
                .listStyle(.grouped)

            }
        } detail: {
            Text("Select an item")
        }
    }

    struct AddItemView: View {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.modelContext) private var modelContext

        @State private var name: String = ""
        @State private var location: String = ""
        @State private var from: Date = Date()
        @State private var till: Date = Date()

        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Information")){
                        TextField("Trip Name", text: $name)
                        TextField("Location", text: $location)
                    }
                    Section(header: Text("Time")){
                        DatePicker("From", selection: $from, displayedComponents: .date)
                        DatePicker("Till", selection: $till, displayedComponents: .date)
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
                        Button("Save") {
                            addItem()
                            dismiss()
                        }
                    }
                }
            }
        }

        private func addItem() {
            withAnimation {
                let newItem = Trip(name: name, location: location, from: from, till: till)
                modelContext.insert(newItem)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Trip.self, inMemory: true)
}

struct ExtractedView: View {
    var trip: Trip
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(trip.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Your trip to \(trip.location)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
            Spacer()
            VStack(alignment: .leading){
                Text(trip.from, format: Date.FormatStyle(date: .abbreviated, time: .omitted)).fontWeight(.light).font(.system(size: 12))
                HStack(){
                    Text(trip.till, format: Date.FormatStyle(date: .abbreviated, time: .omitted)).fontWeight(.light).font(.system(size: 12))
                }
            }
            
        }
    }
}
