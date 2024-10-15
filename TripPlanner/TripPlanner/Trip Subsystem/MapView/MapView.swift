//
//  MapView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var mapViewModel: MapViewModel
    
    var body: some View {
        Map(initialPosition: MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: mapViewModel.latitude,
                    longitude: mapViewModel.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        )
    }
}
