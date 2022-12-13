//
//  RideListView.swift
//  sharemyway
//
//  Created by Pavel Chernov on 17.11.2022.
//

import SwiftUI

struct RideListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Ride.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ride.rideDate, ascending: false)
        ]
    ) var rides: FetchedResults<Ride>
    
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
    }
    
    private func deleteRide(offsets: IndexSet) {
        withAnimation {
            offsets.map { rides[$0] }.forEach(managedObjectContext.delete)
            
            saveContext()
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
