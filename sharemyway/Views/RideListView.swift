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
        // 2.
        entity: Ride.entity(),
        // 3.
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ride.title, ascending: true)
        ]
        //,predicate: NSPredicate(format: "genre contains 'Action'")
        // 4.
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
        
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView()
    }
}
