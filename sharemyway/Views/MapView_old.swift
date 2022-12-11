//
//  MapView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI
import MapKit

//struct MapView_old: UIViewRepresentable {
//
//    @EnvironmentObject var mapData: MapViewModel
//
//    func makeCoordinator() -> Coordinator {
//        return MapView_old.Coordinator()
//    }
//
//    func makeUIView(context: Context) -> MKMapView {
//
//        let view = mapData.mapView
//
//        view.showsUserLocation = true
//        view.delegate = context.coordinator
//
//        return view
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//
//    }
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            let render = MKPolylineRenderer(overlay: overlay)
//            render.strokeColor = .blue
//            render.lineWidth = 4
//
//            return render
//        }
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//            // Custom pins
//
//            // Excluding user blue circle
//
//            if annotation.isKind(of: MKUserLocation.self) {
//                return nil
//            } else {
//                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
//                pinAnnotation.tintColor = .blue
//                pinAnnotation.canShowCallout = true
//
//                return pinAnnotation
//            }
//
//            guard annotation is MKPointAnnotation else { return nil }
//
//                let identifier = "Annotation"
//                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//                if annotationView == nil {
//                    annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                    annotationView!.canShowCallout = true
//                    annotationView?.image = UIImage(systemName: "autostartstop")
//                    annotationView?.tintColor = .green
//                } else {
//                    annotationView!.annotation = annotation
//                }
//
//                return annotationView
//        }
//    }
//}

/* struct MapView_Previews: PreviewProvider {
 static var previews: some View {
 MapView()
 }
 } */