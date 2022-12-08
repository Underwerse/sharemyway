//
//  SearchAddressView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 3.12.2022.
//

import SwiftUI
import MapKit

struct SearchAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var locationManager: LocationManager = .init()
    
    // Mark: Navigation tag to push View to MapView
    @State var navigationTag: String?
    
    @Binding var startPoint: String
    @Binding var destinationPoint: String
    @Binding var startPointCoord: CLLocationCoordinate2D
    @Binding var destinationPointCoord: CLLocationCoordinate2D
    @Binding var btnLabel: String
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                
                Text("Search location")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black)
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Find location here", text: $locationManager.searchText)
                
                if locationManager.searchText != "" {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            locationManager.searchText = ""
                        }
                }
            }
            .foregroundColor(.black)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background{
                RoundedRectangle(cornerRadius:10, style: .continuous)
                    .strokeBorder(.gray)
                    .foregroundColor(.black)
                    .background(Color.white)
            }
            .background(Color.white)
            .padding(.vertical, 10)
            
            if let places = locationManager.fetchedPlaces, !places.isEmpty {
                List {
                    ForEach(places, id: \.self) { place in
                        Button {
                            if let coordinate = place.location?.coordinate {
                                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
                                
                                locationManager.addDraggablePin(coordinate: coordinate)
                                locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                            }
                        } label: {
                            HStack(spacing: 15) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                        .foregroundColor(.primary)
                                    
                                    Text(place.locality ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                    }
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: 400)
            } else {
                // Mark: Live location button
                Button {
                    
                    // Mark: Setting map region
                    if let coordinate = locationManager.userLocation?.coordinate {
                        locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
                        
                        locationManager.addDraggablePin(coordinate: coordinate)
                        locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    }
                } label: {
                    Label {
                        Text("Use Current Location")
                            .font(.callout)
                    } icon: {
                        Image(systemName: "location.north.circle.fill")
                    }
                    .foregroundColor(.green)
                    .background(Color.white)
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background {
            MapViewSelection(startPoint: $startPoint, destinationPoint: $destinationPoint, startPointCoord: $startPointCoord, destinationPointCoord: $destinationPointCoord, btnLabel: $btnLabel)
                .environmentObject(locationManager)
                .navigationBarHidden(true)
        }
    }
}

//struct SearchAddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchAddressView()
//    }
//}

// Mark: MapView live selection
struct MapViewSelection: View {
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State var startPointConfirmed = false
    @State var destinationPointConfirmed = false
    @Binding var startPoint: String
    @Binding var destinationPoint: String
    @Binding var startPointCoord: CLLocationCoordinate2D
    @Binding var destinationPointCoord: CLLocationCoordinate2D
    
    @Binding var btnLabel: String
    var btnConfirmText = ""
    
    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            
            // Mark: Display data
            if let place = locationManager.pickedPlaceMark {
                VStack(spacing: 15){
                    Text("Confirm address")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            Text(place.locality ?? "")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    
                    Button {
                        guard let LAT = place.location?.coordinate.latitude else {return}
                        print("LAT: \(LAT)")
                        guard let LON = place.location?.coordinate.longitude else {return}
                        print("LON: \(LON)")
                        guard let LOCALITY = place.locality else {return}
                        guard let ADDRESS = place.name else {return}
                                                
                        if btnLabel == "start" {
                            startPoint = LOCALITY + ", " + ADDRESS
                            startPointCoord = place.location!.coordinate
                        } else {
                            destinationPoint = LOCALITY + ", " + ADDRESS
                            destinationPointCoord = place.location!.coordinate
                        }
                        
                        startPointConfirmed.toggle()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(
                            !startPointConfirmed ?
                                "Confirm start point" :
                                "Confirm destination point"
                        )
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundColor(.white)
                    }

                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onDisappear {
            locationManager.pickedLocation = nil
            locationManager.pickedPlaceMark = nil
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}

// Mark: UIKit MapView
struct MapViewHelper: UIViewRepresentable {
    
    @EnvironmentObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
