//
//  RideCard.swift
//  sharemyway
//
//  Created by iosdev on 16.11.2022.
//

import SwiftUI

struct RideCard: View {
    var ride: Ride
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 150)
                .foregroundColor(Color(hue: 0.635, saturation: 0.143, brightness: 1.0))
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
            HStack(alignment: .top) {
                HStack(alignment: .top) {
                    Image(ride.creatorAvatar)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 50, height: 50)
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
                .padding(.trailing, -10.0)
                Spacer()
                
                Button {
                    print("like button pressed")
                } label: {
                    Image("like_empty")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 0.0))
                }
                .frame(width: 30.0, height: 30.0)
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

struct RideCard_Previews: PreviewProvider {
    static var previews: some View {
        RideCard(ride: rideList[0])
    }
}
