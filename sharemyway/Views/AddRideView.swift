//
//  AddRide.swift
//  sharemyway
//
//  Created by Pavel Chernov on 6.12.2022.
//

import SwiftUI

struct AddRideView: View {
//    static let DefaultRideTitle = "New Ride"
//    static let DefaultRideStartPoint = "Espoo, Karaportti, 2"
//    static let DefaultRideDestinationPoint = "Espoo, Helsinki, Aleksanterinkatu, 1"
    
    @State var btnLabel = ""
    @State var startPoint = ""
    @State var destinationPoint = ""
    @State var creationDate = Date()
    //    let onComplete: (String, String, String, Date) -> Void
    @State var isModal = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Create new ride")
                        .font(.largeTitle)
                    Button("Pick start point") {
                        self.isModal.toggle()
                        self.btnLabel = "start"
                    }
                    .sheet(isPresented: $isModal) {
                        SearchAddressView(startPoint: $startPoint, destinationPoint: $destinationPoint, btnLabel: $btnLabel)
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
                    .sheet(isPresented: $isModal) {
                        SearchAddressView(startPoint: $startPoint, destinationPoint: $destinationPoint, btnLabel: $btnLabel)
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
                        selection: $creationDate,
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
        //        onComplete(
        //            title.isEmpty ? AddRideView.DefaultRideTitle : title,
        //            startPoint.isEmpty ? AddRideView.DefaultRideStartPoint : startPoint,
        //            destinationPoint.isEmpty ? AddRideView.DefaultRideDestinationPoint : destinationPoint,
        //            creationDate
        //        )
    }
}

struct AddRide_Previews: PreviewProvider {
    static var previews: some View {
        AddRideView()
    }
}
