//
//  AddRide.swift
//  sharemyway
//
//  Created by Pavel Chernov on 6.12.2022.
//

import SwiftUI

struct AddRideView: View {
    static let DefaultRideTitle = "New Ride"
    static let DefaultRideStartPoint = "Espoo, Karaportti, 2"
    static let DefaultRideDestinationPoint = "Espoo, Helsinki, Aleksanterinkatu, 1"
    
    @State var title = ""
    @State var startPoint = ""
    @State var destinationPoint = ""
    @State var creationDate = Date()
    //    let onComplete: (String, String, String, Date) -> Void
    @State var isModal = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack {
                    Button("Pick start point") {
                        self.isModal.toggle()
                    }
                    .sheet(isPresented: $isModal) {
                        SearchAddressView()
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
                    Text("Start point: \(startPoint)")
                }
                VStack {
                    Button("Pick destination point") {
                        self.isModal.toggle()
                    }
                    .sheet(isPresented: $isModal) {
                        SearchAddressView()
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
                    Text("Destination point: \(destinationPoint)")
                }
                VStack(alignment: .leading) {
                    DatePicker(
                        selection: $creationDate,
                        displayedComponents: .date) {
                            Text("Ride date").foregroundColor(Color(.gray))
                        }
                        .padding()
                    Spacer()
                }
            }
            
            
            
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
