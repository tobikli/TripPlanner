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
                    .annotation(position: .overlay) {
                        Text(category.amount, format: .currency(code: "EUR"))
                            .foregroundStyle(.white)
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(category.color)
                }
                .padding()
                .frame(height: 300)
                .chartBackground { _ in
                    Text("Categories")
                }
            }
        }
    }
}
