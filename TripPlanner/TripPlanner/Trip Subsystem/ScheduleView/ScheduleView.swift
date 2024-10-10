import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Environment(\.modelContext) private var modelContext
    var trip: Trip
    
    // Use @State to make events mutable and track changes
    @State private var events: [Event] = []
    @State private var showingAddItemView = false
    
    var body: some View {
            VStack {
                Button(action: {
                    showingAddItemView.toggle()
                }) {
                    Label("Add Event", systemImage: "plus")
                }
                if events.isEmpty {
                    Text("No Events yet")
                        .font(.headline)
                        .fontWeight(.light)
                        .padding(.top)
                } else {
                    List {
                        Section(header: Text("Coming Up")) {
                            ForEach(events.sorted(by: { $0.date < $1.date })) { event in
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
                AddItemView(trip: trip, events: $events)
            }
        .onAppear {
            events = trip.events
        }
    }

    // Delete items from the list
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(events[index])
                events.remove(at: index)
            }
        }
    }
}

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var date = Date()
    @State private var price: Double = 0.0
    @State private var category: String = "Flight"
    
    var trip: Trip
    @Binding var events: [Event] 
    
    var body: some View {
            NavigationView {
                Form {
                    CategoryPicker(category: $category)
                    InformationSection(name: $name, location: $location)
                    TimeSection(date: $date)
                    PriceSection(price: $price)
                }
                .navigationTitle("Create New Event")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Create") {
                            addItem()
                            dismiss()
                        }
                    }
                }
            }
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Event(name: name, location: location, date: date, price: price, category: category)
            modelContext.insert(newItem)
            
            trip.events.append(newItem)
            events.append(newItem)  // Update the state-bound array
        }
    }
}

struct CategoryPicker: View {
    @Binding var category: String
    
    var body: some View {
        Picker("Event Category", selection: $category) {
            Text("Flight").tag("Flight")
            Text("Accommodation").tag("Accommodation")
            Text("Transportation").tag("Transportation")
            Text("Food").tag("Food")
            Text("Activity").tag("Activity")
        }
        .pickerStyle(.inline)
    }
}

struct InformationSection: View {
    @Binding var name: String
    @Binding var location: String
    
    var body: some View {
        Section(header: Text("Information")) {
            TextField("Event Name", text: $name)
            TextField("Location", text: $location)
        }
    }
}

struct TimeSection: View {
    @Binding var date: Date
    
    var body: some View {
        Section(header: Text("Time")) {
            DatePicker("Date", selection: $date, displayedComponents: .date)
        }
    }
}

struct PriceSection: View {
    @Binding var price: Double
    
    var body: some View {
        Section(header: Text("Price")) {
            TextField("Price", value: $price, format: .currency(code: "EUR"))
                .keyboardType(.decimalPad)
        }
    }
}

struct EventDetailView: View {
    var event: Event
    var body: some View {
        HStack {
            Text("This is an event")
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


#Preview {
    ScheduleView(trip: Trip(name: "Cool Trip", location: "Munich", from: Date(), till: Date(), budget: 100))
}
