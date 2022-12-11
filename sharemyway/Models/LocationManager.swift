//
//  LocationManager.swift
//  sharemyway
//
//  Created by Pavel Chernov on 29.11.2022.
//

import SwiftUI
import CoreLocation
import MapKit
// Mark: Combine framework for watching Textfield changes
import Combine

class LocationManager: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    // Mark properties
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    
    // Mark: Search bar text
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?
    
    // Mark: User location
    @Published var userLocation: CLLocation?
    
    // Mark: Final location
    @Published var pickedLocation: CLLocation?
    @Published var pickedPlaceMark: CLPlacemark?
    
    override init() {
        super.init()
        // Mark: Setting Delegate
        manager.delegate = self
        mapView.delegate = self
        
        // Mark: Requesting location access
        manager.requestWhenInUseAuthorization()
        
        // Mark: Search Textfield watching
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
            })
    }
    
    func fetchPlaces(value: String) {
        // Mark: fetching places using MKLocalSearch & Async
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                
                // Use Mainactor to publish changes in Main Thread
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap( { item -> CLPlacemark? in
                        return item.placemark
                    })
                })
            } catch {
                // Handle error
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle error
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentLocation = locations.last else {
            return
        }
        self.userLocation = currentLocation
    }
    
    // Mark: Location authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking permissions
        switch manager.authorizationStatus {
        case .authorizedAlways: manager.requestLocation()
        case .authorizedWhenInUse: manager.requestLocation()
        case .denied: handleLocationError()
        case .notDetermined: manager.requestWhenInUseAuthorization()
        default:
            ()
        }
    }
    
    func handleLocationError() {
        // Handle errors
    }
    
    // Mark: Add draggable Pin to MapView
    func addDraggablePin(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected point"
        
        mapView.addAnnotation(annotation)
    }
    
    // Mark: Enable Pin dragging
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "SELECTEDPIN")
        marker.isDraggable = true
        marker.canShowCallout = false
        
        return marker
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else {return}
        self.pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.longitude)
        
        updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }
    
    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                guard let place = try await reverseLocationCoordinates(location: location) else {return}
                await MainActor.run(body: {
                    self.pickedPlaceMark = place
                })
            }
        }
    }
    
    // Mark: Display new location data
    func reverseLocationCoordinates(location: CLLocation) async throws -> CLPlacemark? {
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }
}
