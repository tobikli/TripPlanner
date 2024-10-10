//
//  CategoriesSectionView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI

struct CategoriesSection: View {
    var categories: [Category]
    
    var body: some View {
        Section(header: Text("Categories")) {
            if categories.isEmpty {
                Text("No Events yet")
            } else {
                List {
                    ForEach(categories) { category in
                        HStack {
                            Circle()
                                .fill(category.color)
                                .frame(width: 10, height: 10)
                            Text("\(category.title):")
                            Text(category.amount, format: .currency(code: "EUR"))
                        }
                    }
                }
            }
        }
    }
}
