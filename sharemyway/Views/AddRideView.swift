//
//  AddRide.swift
//  sharemyway
//
//  Created by Pavel Chernov on 6.12.2022.
//

import SwiftUI
import MapKit

struct AddRideView: View {
    
    // Core Data object
    @Environment(\.managedObjectContext) var managedObjectContext
    // Working with fetching Core Data
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate, order: .reverse)]) var ride: FetchedResults<Ride>
    
    //    static let defaultRideTitle = "Default ride"
    //    static let defaultDriverName = "Default name"
    //    static let defaultStartPoint = "Espoo"
    //    static let defaultDestinationPoint = "Helsinki"
    //    static let defaultStartPointCoord = CLLocationCoordinate2D(latitude: 60.22378, longitude: 24.75826)
    //    static let defaultDestinationPointCoord = CLLocationCoordinate2D(latitude: 60.21378, longitude: 24.73826)
    //    static let defaultRideDate = Date()
    //
    //    let onComplete: (String, String, String, String, String, Double, Double, Double, Double, Date, Date) -> Void
    
    
    // Variable for closing the view
    @Environment(\.dismiss) var dismiss
    
    @State var btnLabel = ""
    @State var title = ""
    @State var driver = ""
    @State var startPoint = ""
    @State var destinationPoint = ""
    @State var startPointCoord = CLLocationCoordinate2D(latitude: 60.22378, longitude: 24.75826)
    @State var destinationPointCoord = CLLocationCoordinate2D(latitude: 60.21378, longitude: 24.73826)
    @State var rideDate = Date()
    @State var isModal = false
    
    // TabView selection var
    //    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            Form {
                Text("Create new ride")
                    .font(.largeTitle)
                    .padding()
                HStack {
                    Text("Ride title: ")
                        .font(.title3.bold())
                        .multilineTextAlignment(.leading)
                    TextField("Ride title", text: $title)
                }
                HStack {
                    Text("Driver name: ")
                        .font(.title3.bold())
                        .multilineTextAlignment(.leading)
                    TextField("Driver name", text: $driver)
                }
                VStack(alignment: .leading) {
                    Button("Pick start point") {
                        self.isModal.toggle()
                        self.btnLabel = "start"
                    }
                    .sheet(isPresented: $isModal) {
                        SearchAddressView(startPoint: $startPoint, destinationPoint: $destinationPoint, startPointCoord: $startPointCoord, destinationPointCoord: $destinationPointCoord, btnLabel: $btnLabel)
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
                }
                HStack {
                    Text("From: ")
                        .font(.title3.bold())
                        .multilineTextAlignment(.leading)
                        .padding()
                    Text(startPoint)
                }
                VStack(alignment: .leading) {
                    Button("Pick destination point") {
                        self.isModal.toggle()
                        self.btnLabel = "destination"
                    }
                    .sheet(isPresented: $isModal) {
                        SearchAddressView(startPoint: $startPoint, destinationPoint: $destinationPoint, startPointCoord: $startPointCoord, destinationPointCoord: $destinationPointCoord, btnLabel: $btnLabel)
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
                }
                HStack {
                    Text("To: ")
                        .font(.title3.bold())
                        .multilineTextAlignment(.leading)
                        .padding()
                    Text(destinationPoint)
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
                    //                    tabSelection = 2
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
                
            }
        }
    }
    
    private func addRideAction() {
        print("Source coord: \(startPointCoord)")
        print("Destination coord: \(destinationPointCoord)")
        
        DataController().addRide(title: title, driver: driver, creatorAvatar: "driver", startPoint: startPoint, destinationPoint: destinationPoint, startPointCoordLat: startPointCoord.latitude, startPointCoordLon: startPointCoord.longitude, destinationPointCoordLat: destinationPointCoord.latitude, destinationPointCoordLon: destinationPointCoord.longitude, rideDate: rideDate, creationDate: Date(), context: managedObjectContext)
        
        //        onComplete(
        //            title.isEmpty ? AddRideView.defaultRideTitle : title,
        //            driver.isEmpty ? AddRideView.defaultDriverName : driver,
        //            startPoint,
        //            destinationPoint,
        //            "driver",
        //            startPointCoord.latitude,
        //            startPointCoord.longitude,
        //            destinationPointCoord.latitude,
        //            destinationPointCoord.longitude,
        //            rideDate,
        //            Date()
        //        )
        
        
    }
}

//struct AddRide_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRideView()
//    }
//}
