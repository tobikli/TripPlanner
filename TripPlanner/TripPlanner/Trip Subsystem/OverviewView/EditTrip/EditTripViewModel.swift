//
//  EditTripViewModel.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//
import Foundation
import SwiftUI

@Observable class EditTripViewModel {
    var name: String = ""
    var location: String = ""
    var from = Date()
    var till = Date()
    var events: [Event] = []
    var budget: Double = 0.0
}


//TODO
