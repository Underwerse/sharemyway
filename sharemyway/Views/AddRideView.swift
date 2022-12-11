//
//  AddRide.swift
//  sharemyway
//
//  Created by Pavel Chernov on 6.12.2022.
//

import SwiftUI
import MapKit
import FirebaseCore
import FirebaseFirestore

struct AddRideView: View {
    
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
    
    // Doc for Firebase
    @State var doc = ""
    
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
        
        saveToFirebase()
    }
    
    func saveToFirebase() {
        let db = Firestore.firestore()
        let sourcePointCoords = GeoPoint(latitude: startPointCoord.latitude, longitude: startPointCoord.longitude)
        let destinationPointCoords = GeoPoint(latitude: destinationPointCoord.latitude, longitude: destinationPointCoord.longitude)
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("rides").addDocument(data: [
            "title": title,
            "driver": driver,
            "startPoint": startPoint,
            "destinationPoint": destinationPoint,
            "startPointCoords": sourcePointCoords,
            "destinationPointCoords": destinationPointCoords,
            "rideDate": rideDate,
            "creationDate": Date()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
