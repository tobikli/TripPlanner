import SwiftUI
import SwiftData

struct ScheduleView: View {
    @State private var trip: Trip
    
    @State private var showingAddItemView = false
    
    var modelContext: ModelContext
    
    init(trip: Trip, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.trip = trip
    }
    
    var body: some View {
            VStack {
                Button(action: {
                    showingAddItemView.toggle()
                }) {
                    Label("Add Event", systemImage: "plus")
                }
                if trip.events.isEmpty {
                    Text("No Events yet")
                        .font(.headline)
                        .fontWeight(.light)
                        .padding(.top)
                } else {
                    List {
                        Section(header: Text("Coming Up")) {
                            ForEach(trip.events.sorted(by: { $0.date < $1.date })) { event in
                                NavigationLink {
                                    EventDetailView(event: event)
                                } label: {
                                    EventBox(event: event)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                    .listStyle(.insetGrouped)
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
            .navigationBarTitle("Schedule", displayMode: .inline)
            .sheet(isPresented: $showingAddItemView) {
                AddEventView(modelContext: modelContext, trip: trip)
            }
    }

    ///Not in ViewModel as it only deletes from list
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trip.events[index])
                trip.events.remove(at: index)
            }
        }
    }
}


struct EventBox: View {
    var event: Event
    var body: some View {
        HStack {
            Image(systemName: "arrow.down")
            Image(systemName: getIconName(category: event.category))
            Text(event.name)
        }
    }
}

func getIconName(category: String) -> String {
    switch category {
    case "Flight": return "airplane"
    case "Accommodation": return "house"
    case "Transportation": return "tram"
    case "Food": return "fork.knife"
    case "Activity": return "figure.run"
    default: return "questionmark.circle"
    }
}
