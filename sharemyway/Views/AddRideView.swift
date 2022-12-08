//
//  AddRide.swift
//  sharemyway
//
//  Created by Pavel Chernov on 6.12.2022.
//

import SwiftUI
import MapKit

struct AddRideView: View {
    
    @State var btnLabel = ""
    @State var rideTitle = ""
    @State var driverName = ""
    @State var startPoint = ""
    @State var destinationPoint = ""
    @State var startPointCoord = CLLocationCoordinate2D(latitude: 60.22378, longitude: 24.75826)
    @State var destinationPointCoord = CLLocationCoordinate2D(latitude: 60.21378, longitude: 24.73826)
    @State var rideDate = Date()
    @State var isModal = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Create new ride")
                        .font(.largeTitle)
                        .padding(.bottom)
//                    Text(NSUserName() + UIDevice.current.identifierForVendor!.uuidString)
//                        .font(.title)
//                        .padding(.bottom)
                    HStack {
                        Text("Ride title: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                        TextField("Ride title", text: $rideTitle)
                    }
                    HStack {
                        Text("Driver name: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                        TextField("Driver name", text: $driverName)
                    }
                    Button("Pick start point") {
                        self.isModal.toggle()
                        self.btnLabel = "start"
                    }
                    .fontWeight(.semibold)
                    .frame(maxWidth: 300)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.blue)
                    }
                    .overlay(alignment: .trailing) {
                        Image(systemName: "arrow.right")
                            .font(.title3.bold())
                            .padding(.trailing)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Text("From: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                            .padding()
                        Text(startPoint)
                    }
                }
                VStack(alignment: .leading) {
                    Button("Pick destination point") {
                        self.isModal.toggle()
                        self.btnLabel = "destination"
                    }
                    .fontWeight(.semibold)
                    .frame(maxWidth: 300)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.blue)
                    }
                    .overlay(alignment: .trailing) {
                        Image(systemName: "arrow.right")
                            .font(.title3.bold())
                            .padding(.trailing)
                    }
                    .foregroundColor(.white)
                    HStack {
                        Text("To: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                            .padding()
                        Text(destinationPoint)
                    }
                }
                VStack(alignment: .leading) {
                    DatePicker(
                        selection: $rideDate,
                        displayedComponents: .date) {
                            Text("Ride date")
                                .font(.title3.bold())
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                    Spacer()
                }
                Spacer()
                Button {
                    addRideAction()
                } label: {
                    Text("Add ride")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.green)
                        }
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $isModal) {
                    SearchAddressView(startPoint: $startPoint, destinationPoint: $destinationPoint, startPointCoord: $startPointCoord, destinationPointCoord: $destinationPointCoord, btnLabel: $btnLabel)
                }
            }
            .padding()
            
            
            
            //            Form {
            //                Section(header: Text("Title")) {
            //                    TextField("Title", text: $title)
            //                }
            //                Section(header: Text("Start point")) {
            //                    Button("Pick start point") {
            //                        self.isModal.toggle()
            //                    }
            //                    .sheet(isPresented: $isModal) {
            //                        MapViewSelection()
            //                    }
            //                    Text("Start point: \($startPoint)")
            //                }
            //                Section(header: Text("Start point")) {
            //                    TextField("Destination point", text: $destinationPoint)
            //                }
            //                Section {
            //                    DatePicker(
            //                        selection: $creationDate,
            //                        displayedComponents: .date) {
            //                            Text("Release Date").foregroundColor(Color(.gray))
            //                        }
            //                }
            //                Section {
            //                    Button(action: addRideAction) {
            //                        Text("Add ride")
            //                    }
            //                }
            //            }
            //            .navigationBarTitle(Text("Add Ride"), displayMode: .inline)
        }
    }
    
    private func addRideAction() {
        print("Source coord: \(startPointCoord)")
        print("Destination coord: \(destinationPointCoord)")
        
        rideList.append(
            RideModel(
                title: rideTitle,
                startPoint: startPoint,
                destinationPoint: destinationPoint,
                startPointCoord: startPointCoord,
                destinationPointCoord: destinationPointCoord,
                rideDate: rideDate,
                driver: driverName,
                creatorAvatar: "avatar",
                creationDate: Date()
            )
        )
        
        //        onComplete(
        //            title.isEmpty ? AddRideView.DefaultRideTitle : title,
        //            startPoint.isEmpty ? AddRideView.DefaultRideStartPoint : startPoint,
        //            destinationPoint.isEmpty ? AddRideView.DefaultRideDestinationPoint : destinationPoint,
        //            creationDate
        //        )
    }
}

//struct AddRide_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRideView()
//    }
//}
