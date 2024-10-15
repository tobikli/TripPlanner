//
//  TripBoxView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI

struct TripBox: View {
    var trip: Trip
    var body: some View {
        HStack {
            Image(systemName: "globe.europe.africa")
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .padding(.horizontal, 2)
            VStack(alignment: .leading) {
                Text(trip.name)
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Your trip to \(trip.location)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 2)
            Spacer()

            VStack(alignment: .center) {
                Text(trip.from, format: Date.FormatStyle()
                        .day(.twoDigits)
                        .month(.abbreviated))
                    .fontWeight(.light)
                    .font(.system(size: 12))
                    .padding(.bottom, 2)
                Text(trip.till, format: Date.FormatStyle()
                        .day(.twoDigits)
                        .month(.abbreviated))
                    .fontWeight(.light)
                    .font(.system(size: 12))
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(.primary, lineWidth: 0.5)
            )
            Spacer()
                .frame(maxWidth: 20)
        }
    }
}
