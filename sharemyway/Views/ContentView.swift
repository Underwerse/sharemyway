import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RideListView()
                .tabItem() {
                    Label("Rides list", systemImage: "list.bullet.rectangle.fill")
                }
            MapView()
                .tabItem() {
                    Label("Rides map", systemImage: "map.fill")
                }
        }
        .foregroundColor(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
