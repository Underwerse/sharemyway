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
import iPhoneNumberField

struct AddRideView: View {
    private enum Field: Int, CaseIterable {
        case title, driver, creatorPhone
    }
    // Variable for closing the view
    @Environment(\.dismiss) var dismiss
    // Core Data object
    @Environment(\.managedObjectContext) var managedObjectContext
    let persistenceController = PersistenceController.shared
    
    @State var btnLabel = ""
    @State var title = ""
    @State var driver = ""
    @State var creatorPhone = ""
    @State var startPoint = ""
    @State var destinationPoint = ""
    @State var startPointCoord = CLLocationCoordinate2D(latitude: 60.22378, longitude: 24.75826)
    @State var destinationPointCoord = CLLocationCoordinate2D(latitude: 60.21378, longitude: 24.73826)
    @State var rideDate = Date()
    @State var isModal = false
    @State var addButtonDisabled = false
    
    // Doc for Firebase
    @State var doc = ""
    @State var documentID = ""
    
    @State var isPresented = false
    @FocusState private var focusedField : Field?
    
    // TabView selection var
    //    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            //            Form {
            VStack {
                Group {
                    Text("Create new ride")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        Text("Ride title: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                        TextField("Ride title", text: $title)
                            .font(.title2)
                            .focused($focusedField, equals: .title)
                    }
                    
                    HStack {
                        Text("Driver name: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                        TextField("Driver name", text: $driver)
                            .font(.title2)
                            .focused($focusedField, equals: .driver)
                    }
                    
                    HStack {
                        Text("Phone num: ")
                            .font(.title3.bold())
                            .multilineTextAlignment(.leading)
                        iPhoneNumberField("(040) 123-4567", text: $creatorPhone)
                            .flagHidden(true)
                            .maximumDigits(11)
                            .font(UIFont(size: 20, weight: .light, design: .monospaced))
                            .focused($focusedField, equals: .creatorPhone)
                    }
                }
                
                Group {
                    VStack(alignment: .leading) {
                        Button("Pick start point") {
                            self.isModal.toggle()
                            self.btnLabel = "start"
                            focusedField = nil
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
                        Text(startPoint)
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    Button("Pick destination point") {
                        self.isModal.toggle()
                        self.btnLabel = "destination"
                        focusedField = nil
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
                    Text(destinationPoint)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    DatePicker(
                        selection: $rideDate,
                        displayedComponents: .date) {
                            Text("Ride date")
                                .font(.title3.bold())
                                .multilineTextAlignment(.leading)
                        }
                    Spacer()
                }
                
                Button {
                    saveToFirebase()
                    //                    tabSelection = 2
                } label: {
                    Text("Add ride")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill( !(title != "" && driver != "" && startPoint != "" && destinationPoint != "") ? .gray : .green)
                        }
                        .foregroundColor(.white)
                }
                .disabled( (title != "" && driver != "" && startPoint != "" && destinationPoint != "") ? false : true )
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Hide keyboard") {
                        focusedField = nil
                    }
                }
            }
            .padding()
            
            //            }
            
        }
        .alert("Ride has been successfully added", isPresented: $isPresented) {}
    }
    
    private func clearFormData() {
        self.title = ""
        self.creatorPhone = ""
        self.driver = ""
    }
    
    private func saveToFirebase() {
        let db = Firestore.firestore()
        let sourcePointCoords = GeoPoint(latitude: startPointCoord.latitude, longitude: startPointCoord.longitude)
        let destinationPointCoords = GeoPoint(latitude: destinationPointCoord.latitude, longitude: destinationPointCoord.longitude)
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("rides").addDocument(data: [
            "title": title,
            "driver": driver,
            "creatorPhone": creatorPhone,
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
                documentID = ref!.documentID
                
                // Save to CoreData
                persistenceController.addRide(
                    documentID: documentID,
                    title: title,
                    driver: driver,
                    creatorAvatar: "driver",
                    creatorPhone: creatorPhone,
                    startPoint: startPoint,
                    destinationPoint: destinationPoint,
                    startPointCoordLat: startPointCoord.latitude,
                    startPointCoordLon: startPointCoord.longitude,
                    destinationPointCoordLat: destinationPointCoord.latitude,
                    destinationPointCoordLon: destinationPointCoord.longitude,
                    rideDate: rideDate,
                    creationDate: Date(),
                    context: managedObjectContext
                )
                isPresented.toggle()
                clearFormData()
                //                self.tabSelection = 1
            }
        }
    }
}
