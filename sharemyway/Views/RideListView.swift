//
//  RideListView.swift
//  sharemyway
//
//  Created by iosdev on 17.11.2022.
//

import SwiftUI

struct RideListView: View {
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

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView()
    }
}
