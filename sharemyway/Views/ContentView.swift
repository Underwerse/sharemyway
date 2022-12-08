//
//  ContentView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // Set TabView var for transitions
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            RideListView()
                .tabItem() {
                    Label("Rides list", systemImage: "list.bullet.rectangle.fill")
                }
            MapViewScreen()
                .tabItem() {
                    Label("Rides map", systemImage: "map.fill")
                }
            AddRideView(tabSelection: $tabSelection)
                .tabItem() {
                    Label("Add ride", systemImage: "plus.app.fill")
                }
        }
        .foregroundColor(Color.black)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapViewScreen()
        }
    }
}
