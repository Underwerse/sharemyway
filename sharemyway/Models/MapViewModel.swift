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
    
    // Core Data object
    @Environment(\.managedObjectContext) var managedObjectContext
    let persistenceController = PersistenceController.shared
    
    @Published var mapView = MKMapView()
    
    // Location manager
    let locationManager = CLLocationManager()
    
    // Region
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.216905, longitude: 24.935865), latitudinalMeters: 30000, longitudinalMeters: 30000)
    
    // Alert
    @Published var permissionDenied = false
    
    // Map type
    @Published var mapType: MKMapType = .standard
    
    // Search text
    @Published var searchTxt = ""
    
    // Searched places
    @Published var places: [Place] = []
    
    // Rides array
    @Published var ridesFirebase: [RidesModel] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManagerDidChangeAuthorization()
        getRidesFromFirebase()
    }
    
    // Get rides from Firebase
    func getRidesFromFirebase() {
        let db = Firestore.firestore()
        var documentID = ""
        var title = ""
        var driver = ""
        var creatorPhone = ""
        var startPoint = ""
        var destinationPoint = ""
        var startPointCoord = CLLocationCoordinate2D(latitude: 60.22378, longitude: 24.75826)
        var destinationPointCoord = CLLocationCoordinate2D(latitude: 60.21378, longitude: 24.73826)
        var rideDate = Date()
        var creationDate = Date()
        
        db.collection("rides").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    // Retrieve documentID from the document
                    print("DOC ID from Firebase: \(document.documentID)")
                    documentID = document.documentID
                    
                    // Retrieve title from the document
                    if let titleDoc = document.get("title") {
                        title = titleDoc as! String
                    }
                    
                    // Retrieve driver from the document
                    if let driverDoc = document.get("driver") {
                        driver = driverDoc as! String
                    }
                    
                    // Retrieve driver's phone from the document
                    if let creatorPhoneDoc = document.get("creatorPhone") {
                        creatorPhone = creatorPhoneDoc as! String
                    }
                    
                    // Retrieve start point from the document
                    if let startPointDoc = document.get("startPoint") {
                        startPoint = startPointDoc as! String
                    }
                    
                    // Retrieve destination point from the document
                    if let destinationPointDoc = document.get("destinationPoint") {
                        destinationPoint = destinationPointDoc as! String
                    }
                    
                    // Retrieve ride Date from the document
                    if let rideDateDoc = document.get("rideDate") {
                        let timestamp = rideDateDoc as! Timestamp
                        rideDate = timestamp.dateValue()
                    }
                    
                    // Retrieve creation Date from the document
                    if let creationDateDoc = document.get("creationDate") {
                        let timestamp = creationDateDoc as! Timestamp
                        creationDate = timestamp.dateValue()
                    }
                    
                    // Retrieve coordinates from the document
                    if let startPointCoordsDoc = document.get("startPointCoords") {
                        let startPointCoords = startPointCoordsDoc as! GeoPoint
                        startPointCoord = CLLocationCoordinate2D(latitude: startPointCoords.latitude, longitude: startPointCoords.longitude)
                    }
                    if let destinationPointCoords = document.get("destinationPointCoords") {
                        let destinationPointCoords = destinationPointCoords as! GeoPoint
                        destinationPointCoord = CLLocationCoordinate2D(latitude: destinationPointCoords.latitude, longitude: destinationPointCoords.longitude)
                    }
                    
                    self.ridesFirebase.append(
                        RidesModel(
                            documentID: documentID,
                            title: title,
                            driver: driver,
                            creatorPhone: creatorPhone,
                            startPoint: startPoint,
                            destinationPoint: destinationPoint,
                            startPointCoord: startPointCoord,
                            destinationPointCoord: destinationPointCoord,
                            rideDate: rideDate,
                            creationDate: creationDate
                        )
                    )
                }
                
                self.loadRidesToCoreData()
            }
        }
    }
    
    // Load rides from Firebase to Core Data
    func loadRidesToCoreData() {
        
        persistenceController.deleteAllData("Ride")
        
        print("ridesFirebase ARR length: \(self.ridesFirebase.count)")
        print("START adding rides to CoreData")
        
        for ride in self.ridesFirebase {
            
            print("RIDE before add to CoreData: \(ride)")
            
            persistenceController.addRide(
                documentID: ride.documentID,
                title: ride.title,
                driver: ride.driver,
                creatorAvatar: "driver",
                creatorPhone: ride.creatorPhone,
                startPoint: ride.startPoint,
                destinationPoint: ride.destinationPoint,
                startPointCoordLat: ride.startPointCoord.latitude,
                startPointCoordLon: ride.startPointCoord.longitude,
                destinationPointCoordLat: ride.destinationPointCoord.latitude,
                destinationPointCoordLon: ride.destinationPointCoord.longitude,
                rideDate: ride.rideDate,
                creationDate: ride.creationDate,
                context: managedObjectContext
            )
        }
        
        print("Rides have been added to CoreData")
    }
    
    // Draw rides
    func showRidesOnMap(rides: FetchedResults<Ride>) {
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        for ride in rides {
            
            print("RIDE fetched from CoreData")
            print(ride)
            
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
    
    func locationManagerDidChangeAuthorization() {
        
        // Checking permissions
        switch locationManager.authorizationStatus {
        case .denied:
            // Alert
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            // If permission given
            locationManager.requestLocation()
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
        
        guard let latestLocation = locations.first else {
            // Shown error
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
        
        mapView.setRegion(region, animated: true)
    }
}
