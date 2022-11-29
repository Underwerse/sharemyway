//
//  RideDetailView.swift
//  sharemyway
//
//  Created by iosdev on 17.11.2022.
//

import SwiftUI

struct RideDetailView: View {
    var ride: Ride
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .center) {
                Image(ride.creatorAvatar)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 150, height: 150)
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Driver:")
                            .bold()
                        Text("\(ride.creatorName)")
                        
                    }
                    .padding(.bottom, 1)
                    HStack(alignment: .top) {
                        Text("From:")
                            .bold()
                        Text("\(ride.startPoint)")
                    }
                    .padding(.bottom, 1)
                    HStack(alignment: .top) {
                        Text("To:")
                            .bold()
                        Text("\(ride.finishPoint)")
                    }
                    .padding(.bottom, 1)
                    HStack {
                        Text("Description:")
                            .bold()
                        Text("\(ride.description)")
                    }
                }
                .padding(.leading)
            }
        }
        .navigationTitle("Ride detail")
    }
}

struct RideDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RideDetailView(ride: rideList[0])
    }
}
