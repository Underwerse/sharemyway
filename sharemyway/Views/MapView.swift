import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
//    var body: some View {
//        ZStack {
//            Color.blue
//
//            Image(systemName: "map.fill")
//                .foregroundColor(Color.white)
//                .font(.system(size: 100))
//        }
//    }
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
