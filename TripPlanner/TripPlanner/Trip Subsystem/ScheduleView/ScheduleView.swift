import SwiftUI
import SwiftData
import AlertToast

struct ScheduleView: View {
    @State private var trip: Trip
    
    @State private var showingAddEventView = false
    
    @State private var showAlert = false
    
    var modelContext: ModelContext
    
    init(trip: Trip, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.trip = trip
    }
    
    var body: some View {
            VStack {
                Button(action: {
                    showingAddEventView.toggle()
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
                    .listStyle(.plain)
                }
            }
            .navigationBarTitle("Schedule", displayMode: .inline)
            .sheet(isPresented: $showingAddEventView) {
                AddEventView(modelContext: modelContext, trip: trip, showAlert: $showAlert)
            }
            .toast(isPresenting: $showAlert, duration: 3) {
                AlertToast(displayMode: .banner(.slide),
                           type: .complete(.primary),
                           title: "Created new Event for \(trip.name)",
                           subTitle: "Your Event has been created successfully")
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
            Spacer()
            Image(systemName: getIconName(category: event.category))
            Spacer()
            VStack {
                Text(event.name)
                    .font(.headline)
                Text(event.date.formatted(.dateTime))
            }
            Spacer()
        }
    }
}

func getIconName(category: String) -> String {
    switch category {
    case "Flight": "airplane"
    case "Accommodation": "house"
    case "Transportation": "tram"
    case "Food": "fork.knife"
    case "Activity": "figure.run"
    default: "questionmark.circle"
    }
}
