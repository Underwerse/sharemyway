import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(rideList, id: \.id) { ride in
                    NavigationLink(destination: RideDetailView(ride: ride)) {
                        RideCard(ride: ride)
                    }
                }
            }
        }
        .navigationTitle("ShareMyWay! rides list")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
