//
//  WeatherSectionView.swift
//  TripPlanner
//
//  Created by Tobias Klingenberg on 10.10.24.
//

import SwiftUI

struct WeatherSection: View {
    var validWeather: Bool
    var location: String
    var weatherIcon: String
    var temperature: String
    
    var body: some View {
        Section(header: Text("Weather")) {
            VStack {
                if validWeather {
                    Spacer()
                    Text("The weather currently in \(location)")
                        .font(.custom("MediteraRounded-RegularDemo", size: 22))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 2)
                    Spacer()
                    HStack {
                        Image(systemName: weatherIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .padding()
                        Text(temperature)
                            .font(.system(size: 40))
                    }
                    Spacer()
                } else {
                    Text("Could not fetch weather")
                        .foregroundStyle(.red)
                }
            }
        }
    }
}
