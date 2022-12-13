//
//  MapView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI
import MapKit

struct MapViewController: UIViewRepresentable {
    
    @EnvironmentObject var mapViewModel: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapViewController.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapViewModel.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 4
            
            return render
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            // Excluding user blue circle
            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            } else {
                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .blue
                pinAnnotation.canShowCallout = true

                return pinAnnotation
            }
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {}

    }
}

/* struct MapView_Previews: PreviewProvider {
 static var previews: some View {
 MapView()
 }
 } */
