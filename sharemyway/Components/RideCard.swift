//
//  RideCard.swift
//  sharemyway
//
//  Created by Pavel Chernov on 16.11.2022.
//

import SwiftUI

struct RideCard: View {
    var ride: Ride
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 150)
                .foregroundColor(Color("CardBgrColor"))
                .shadow(color: .gray, radius: 5, x: 5, y: 5)
            HStack(alignment: .top) {
                HStack(alignment: .top) {
//                    Image("driver")
//                        .resizable()
//                        .cornerRadius(20)
//                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("Driver:")
                                .bold()
                            Text(ride.title!)
                                
                        }
                        .padding(.bottom, 1)
                        HStack(alignment: .top) {
                            Text("From:")
                                .bold()
                            Text(ride.startPoint!)
                        }
                        .padding(.bottom, 1)
                        HStack(alignment: .top) {
                            Text("To:")
                                .bold()
                            Text(ride.destinationPoint!)
                        }
                        .padding(.bottom, 1)
                        HStack(alignment: .top) {
                            Text("Date:")
                                .bold()
                            Text(dateToString(date: ride.rideDate!))
                        }
                        .padding(.bottom, 1)
                    }
                    
                }
//                .padding(.trailing, -10.0)
//                Spacer()
//
//                Button {
//                    print("like button pressed")
//                } label: {
//                    Image("like_empty")
//                        .resizable(resizingMode: .stretch)
//                        .frame(width: 30, height: 30)
//                        .padding(10)
//                        .background(Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 0.0))
//                }
//                .frame(width: 30.0, height: 30.0)
            }
        }
        .foregroundColor(.white)
//        .padding(.horizontal)
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YY"
        print(date)
        print(dateFormatter.string(from: date))
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

//struct RideCard_Previews: PreviewProvider {
//    static var previews: some View {
//        RideCard(ride: ride)
//    }
//}
