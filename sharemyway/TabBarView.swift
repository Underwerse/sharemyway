//
//  TabBarView.swift
//  sharemyway
//
//  Created by iosdev on 15.11.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            RideView().tabItem {
                Label("Rides", systemImage: "car.fill")
            }.accessibilityLabel("Rides tab button")
            Text("map placeholder").tabItem {
                Label("Map", systemImage: "map.fill")
            }.accessibilityLabel("Map tab button")
            Text("messages placeholder").tabItem {
                Label("Messages", systemImage: "envelope.fill")
            }.accessibilityLabel("Messages tab button")
            Text("profile placeholder").tabItem {
                Label("Profile", systemImage: "person.fill")
            }.accessibilityLabel("Profile tab button")
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
