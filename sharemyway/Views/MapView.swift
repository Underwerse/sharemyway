//
//  MapView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 11.12.2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
                .ignoresSafeArea(.all, edges: .top)
                .tint(.pink)
            
            Button(action: {
                mapViewModel.locationManagerDidChangeAuthorization()
            }, label: {
                Image(systemName: "location.fill")
                    .font(.title2)
                .padding(10)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                .clipShape(Circle())
            })
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
