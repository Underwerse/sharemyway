//
//  MapViewModel.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreData
import FirebaseCore
import FirebaseFirestore

// All map data goes here

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var defaultRegionCoord = CLLocationCoordinate2D(latitude: 60.216905, longitude: 24.935865)
    
    @Published var mapView = MKMapView()
    
    // Region
    @Published var region: MKCoordinateRegion!
    // Based on location it will set up
    
    // Alert
    @Published var permissionDenied = false
    
    // Map type
    @Published var mapType: MKMapType = .standard
    
    // Search text
    @Published var searchTxt = ""
    
    // Searched places
    @Published var places: [Place] = []
    
    // Rides array
    @Published var ridesFirebase: [Ride] = []
    
    override init() {
        super.init()
        self.region = self.setDefaultRegion()
        self.getRidesFromFirebase()
    }
    
    // Get rides from Firebase
    func getRidesFromFirebase() -> [Ride] {
        let db = Firestore.firestore()
        var rides = [Ride]()
        
        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    // Retrieve coordinates from the document
                    if let startPointCoords = document.get("startPoint") {
                        let startPointCoords = startPointCoords as! GeoPoint
                        let startPointCoord = CLLocationCoordinate2D(latitude: startPointCoords.latitude, longitude: startPointCoords.longitude)
                        print(startPointCoord)
                    }
                    if let destinationPointCoords = document.get("destinationPoint") {
                        let destinationPointCoords = destinationPointCoords as! GeoPoint
                        let destinationPointCoord = CLLocationCoordinate2D(latitude: destinationPointCoords.latitude, longitude: destinationPointCoords.longitude)
                        print(destinationPointCoord)
                    }
                }
            }
        }
        
        return rides
    }
    
    // Set default region Helsinki
    func setDefaultRegion() -> MKCoordinateRegion {
        let region = MKCoordinateRegion(center: defaultRegionCoord, latitudinalMeters: 30000, longitudinalMeters: 30000)
        self.mapView.setRegion(region, animated: true)
        return region
    }
    
    // Draw rides
    func showRidesOnMap(rides: FetchedResults<Ride>) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        for ride in rides {
            
            let sourceCoordinate = CLLocationCoordinate2D(latitude: ride.startPointCoordLat, longitude: ride.startPointCoordLon)
            let destinationCoordinate = CLLocationCoordinate2D(latitude: ride.destinationPointCoordLat, longitude: ride.destinationPointCoordLon)
            
            let sourcePin = MKPointAnnotation()
            sourcePin.coordinate = sourceCoordinate
            sourcePin.title = ride.startPoint
            sourcePin.subtitle = "start"
            mapView.addAnnotation(sourcePin)
            
            let destinationPin = MKPointAnnotation()
            destinationPin.coordinate = destinationCoordinate
            destinationPin.title = ride.destinationPoint
            destinationPin.subtitle = "destination"
            mapView.addAnnotation(destinationPin)
            
            let req = MKDirections.Request()
            req.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
            req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
            
            let directions = MKDirections(request: req)
            directions.calculate { (direct, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                let polyline = direct?.routes.first?.polyline
                self.mapView.addOverlay(polyline!)
            }
        }
    }
    
    // Updating map type
    func updateMapType() {
        
        if mapType == .standard {
            mapType = .hybrid
        } else {
            mapType = .standard
        }
        mapView.mapType = mapType
    }
    
    // Focus location
    func focusLocation() {
        
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // Search place
    func searchQuery() {
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        // Fetch
        MKLocalSearch(request: request).start { (response, _) in
            
            guard let result = response else {return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    // Pick search result
    func selectPlace(place: Place) {
        
        // Showing pin on the map
        searchTxt = ""
        
        guard let coordinate = place.place.location?.coordinate else {return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No name"
        
        // Removing all old annotations
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        // Moving map to searched selected place location
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking permissions
        switch manager.authorizationStatus {
        case .denied:
            // Alert
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // If permission given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // Error
        print(error.localizedDescription)
    }
    
    // Getting user region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            setDefaultRegion()
            return
        }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        // Updating map
        self.mapView.setRegion(self.region, animated: true)
        
        // Smooth animations
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
