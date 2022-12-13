//
//  RideDetailView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 17.11.2022.
//

import SwiftUI

struct RideDetailView: View {
    var ride: Ride
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .center) {
                
                Spacer()
                
                Image(ride.creatorAvatar!)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 150, height: 150)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text("Driver:")
                            .bold()
                        Text(ride.driver!)
                        
                    }
                    .padding(.bottom, 1)
                    
                    HStack(alignment: .top) {
                        Text("Driver's phone num:")
                            .bold()
                        Text(ride.creatorPhone!)
                        
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
                        Text("Ride date:")
                            .bold()
                        Text(dateToString(date: ride.rideDate!))
                    }
                    .padding(.bottom, 1)
                }
                .padding(.leading)
                
                Spacer()
            }
        }
        .navigationTitle("Ride detail")
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YY"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

//struct RideDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RideDetailView(ride: Ride)
//    }
//}
