//
//  DataSectionView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI


struct DatesSection: View {
    var from: String
    var till: String
    
    var body: some View {
        Section(header: Text("Dates")) {
            HStack {
                Text("From:")
                Spacer()
                Text(from)
            }
            
            HStack {
                Text("Until:")
                Spacer()
                Text(till)
            }
        }
    }
}
