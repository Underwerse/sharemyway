import SwiftUI
import CoreLocation

struct MapViewScreen: View {
    
    @StateObject var mapData = MapViewModel()
    // Location manager
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack {
            
            // MapView
            MapView()
            // Using it as an environment object to be used then in it's subviews
                .environmentObject(mapData)
//                .ignoresSafeArea(.all, edges: .all)
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
    }
}

struct MapViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapViewScreen()
    }
}
