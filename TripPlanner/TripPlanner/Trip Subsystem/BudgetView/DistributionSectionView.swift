//
//  DistributionSectionView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import Charts

struct DistributionSection: View {
    var categories: [Category]
    
    var body: some View {
        Section(header: Text("Distribution")) {
            if categories.isEmpty {
                Text("No Events yet")
            } else {
                Chart(categories) { category in
                    SectorMark(
                        angle: .value("Amount", category.amount),
                        innerRadius: .ratio(0.6),
                        angularInset: 8
                    )
                    .foregroundStyle(category.color)
                }
                .padding()
                .frame(height: 300)
            }
        }
    }
}
