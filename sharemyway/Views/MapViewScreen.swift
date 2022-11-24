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
            
            VStack {
                
                Spacer()
                
                VStack {
                    
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
    }
}

struct MapViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapViewScreen()
    }
}
