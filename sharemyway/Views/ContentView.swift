//
//  ContentView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RideListView()
                .tabItem() {
                    Label("Rides list", systemImage: "list.bullet.rectangle.fill")
                }
            MapViewScreen()
                .tabItem() {
                    Label("Rides map", systemImage: "map.fill")
                }
//            SearchAddressView()
//                .tabItem() {
//                    Label("SearchAddressTemp", systemImage: "magnifyingglass.circle.fill")
//                }
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
