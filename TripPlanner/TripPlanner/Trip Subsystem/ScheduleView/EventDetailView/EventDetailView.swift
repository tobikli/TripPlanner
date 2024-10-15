//
//  EventDetailView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import AlertToast

struct EventDetailView: View {
    @State var event: Event
    @State private var editMode = false
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: getIconName(category: event.category))
                        .resizable()
                        .frame(width: 50, height: 50)
                    Spacer()
                }
                Section(header: Text("Information")) {
                    Text("Type: \(event.category)")
                    if editMode {
                        EventEditView(event: $event)
                    } else {
                        Text("Name: \(event.name)")
                        Text("Location: \(event.location)")
                        Text("From: \(event.from.formatted())")
                        Text("Until: \(event.until.formatted())")
                        Text("Cost: \(event.cost.formatted(.currency(code: "EUR")))")
                    }
                }
                if event.category == "Flight" {
                    Section(header: Text("Flight Information")) {
                        if editMode {
                            TextField(event.flightNumber, text: $event.flightNumber)
                        } else {
                            Text("Flight Number: \(event.flightNumber)")
                        }
                    }
                }
            }
            .navigationTitle(Text(event.name))
            .navigationBarTitleDisplayMode(.inline)
        }
        .toast(isPresenting: $showAlert, duration: 1.5) {
            AlertToast(type: .complete(.primary), title: "Saved Event")
        }
        .navigationBarItems(
            trailing: Button(action: {
                if editMode {
                    showAlert.toggle()
                }
                editMode.toggle()
            }) {
                editMode ? Text("Done") : Text("Edit")
            }
        )
    }

    struct EventEditView: View {
        @Binding var event: Event

        var body: some View {
            ZStack(alignment: .trailing) {
                TextField(event.name, text: $event.name)
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            ZStack(alignment: .trailing) {
                TextField(event.location, text: $event.location)
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            DatePicker("From", selection: $event.from)
            DatePicker("Until", selection: $event.until)
            ZStack(alignment: .trailing) {
                TextField(
                    event.cost.formatted(.currency(code: "EUR")),
                    value: $event.cost,
                    format: .currency(code: "EUR")
                )
                .keyboardType(.decimalPad)
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
        }
    }
}
