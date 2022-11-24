import SwiftUI
import MapKit
import CoreLocation

// All map data goes here

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    
    // Region
    @Published var region: MKCoordinateRegion!
    // Based on location it will set up
    // Alert
    @Published var permissionDenied = false
    
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
            return
        }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // Updating map
        self.mapView.setRegion(self.region, animated: true)
        
        // Smooth animations
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
