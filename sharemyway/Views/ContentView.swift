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
//    @State private var tabSelection = 1
    
    var body: some View {
//        TabView(selection: $tabSelection) {
        TabView() {
            RideListView()
                .tabItem() {
                    Label("Rides list", systemImage: "list.bullet.rectangle.fill")
                }
            MapView()
                .tabItem() {
                    Label("Rides map", systemImage: "map.fill")
                }
//            AddRideView(tabSelection: $tabSelection)
            AddRideView()
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
