//
//  RideListView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 17.11.2022.
//

import SwiftUI
import FirebaseFirestore

struct RideListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Ride.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ride.creationDate, ascending: false)
        ]
    ) var rides: FetchedResults<Ride>
    
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rides, id: \.id) { ride in
                    NavigationLink(destination: RideDetailView(ride: ride)) {
                        RideCard(ride: ride)
                    }
                }
                .onDelete(perform: deleteRide)
            }
            .listStyle(.plain)
//            .background(.white)
            .navigationTitle("ShareMyWay!")
        }
        .navigationViewStyle(.stack)
        .alert("Ride has been successfully deleted", isPresented: $isPresented) {}
    }
    
    private func deleteRide(offsets: IndexSet) {
        
        withAnimation {
            
            // Delete from CoreData
            offsets.map { rides[$0] }.forEach(managedObjectContext.delete)
            // Delete from Firebase
            let db = Firestore.firestore()
            offsets.map { rides[$0] }.forEach { ride in
                guard let rideID = ride.documentID else { return }
                db.collection("rides").document(rideID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {}
                }
            }
            
            saveContext()
            isPresented.toggle()
        }
    }
    
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView()
    }
}
