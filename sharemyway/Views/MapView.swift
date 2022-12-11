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
    @State var setRoute = false
    @State var isRidesShown = false

    // Rides
    @FetchRequest(
        entity: Ride.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ride.rideDate, ascending: false)
        ]
    ) var rides: FetchedResults<Ride>
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
                .ignoresSafeArea(.all, edges: .top)
                .tint(.pink)
            
            VStack {
                
                VStack(spacing: 0) {
                    HStack {

                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("Search", text: $mapViewModel.searchTxt)

                        if mapViewModel.searchTxt != "" {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    mapViewModel.searchTxt = ""
                                }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white.clipShape(RoundedRectangle(cornerRadius:10)))

                    // Displaying results
                    if !mapViewModel.places.isEmpty && mapViewModel.searchTxt != "" {

                        ScrollView {

                            VStack(spacing: 15) {

                                ForEach(mapViewModel.places) { place in

                                    Text(place.place.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            mapViewModel.selectPlace(place: place)
                                        }

                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .background(Color.white)
                    }
                }
                .padding()

                Spacer()
                
                VStack {
                    Button {
    //                    if !isRidesShown {
    //                        mapViewModel.showRidesOnMap(rides: rides)
    //                    } else {
    //                        mapViewModel.mapView.removeAnnotations(mapViewModel.mapView.annotations)
    //                        mapViewModel.mapView.removeOverlays(mapViewModel.mapView.overlays)
    //                    }
                        isRidesShown.toggle()
                    } label: {
                        Image(systemName: "point.topleft.down.curvedto.point.filled.bottomright.up")
                            .font(.title2)
                        .padding(10)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                        .clipShape(Circle())
                    }
                    
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
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
