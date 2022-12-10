//
//  MapViewScreen.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI
import CoreLocation
import MapKit
import Firebase

struct MapViewScreen: View {
    
    @StateObject var mapData = MapViewModel()
    // Location manager
    @State var locationManager = CLLocationManager()
    // Start point address
//    @State var start
    // Set marker to the map and sent to Firebase trigger
    @State var setRoute = false
    // Doc for Firebase
    @State var doc = ""
    
    @State var isRidesShown = false
    
    // Rides
    @FetchRequest(
        entity: Ride.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ride.rideDate, ascending: true)
        ]
    ) var rides: FetchedResults<Ride>
        
    var body: some View {
        
        ZStack {
            
            // MapView
            MapView()
            // Using it as an environment object to be used then in it's subviews
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .top)
            
            VStack {
                
                VStack(spacing: 0) {
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $mapData.searchTxt)
                        
                        if mapData.searchTxt != "" {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    mapData.searchTxt = ""
                                }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white.clipShape(RoundedRectangle(cornerRadius:10)))
                    
                    // Displaying results
                    if !mapData.places.isEmpty && mapData.searchTxt != "" {
                        
                        ScrollView {
                            
                            VStack(spacing: 15) {
                                
                                ForEach(mapData.places) { place in

                                    Text(place.place.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            mapData.selectPlace(place: place)
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
                        if !isRidesShown {
                            mapData.showRidesOnMap(rides: rides)
                        } else {
                            mapData.mapView.removeAnnotations(mapData.mapView.annotations)
                        }
                        isRidesShown.toggle()
                    } label: {
                        Image(systemName: "point.topleft.down.curvedto.point.filled.bottomright.up")
                            .font(.title2)
                        .padding(10)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                        .clipShape(Circle())
                    }
                    
                    Button(action: mapData.focusLocation, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                        .padding(10)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                        .clipShape(Circle())
                    })
                    
                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType ==
                            .standard ? "network" : "map")
                        .font(.title2)
                        .padding(10)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.4))
                        .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .onAppear(perform: {
            
            // Setting delegate
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        // Permission denied alert
        .alert(isPresented: $mapData.permissionDenied, content: {
            
            Alert(title: Text("Permission denied"), message: Text("Please enable permission in App settings"), dismissButton: .default(Text("Go to Settings"), action: {
                
                // Redirecting user to Settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
        .onChange(of: mapData.searchTxt, perform: {value in
            
            // Searching place
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    
                    // Search
                    self.mapData.searchQuery()
                }
            }
        })
    }
}

struct MapViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapViewScreen()
    }
}

