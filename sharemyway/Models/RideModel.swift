//
//  Ride.swift
//  sharemyway
//
//  Created by iosdev on 16.11.2022.
//

import SwiftUI

struct RideModel: Identifiable {
    var id = UUID()
    var description: String
    var startPoint: String
    var finishPoint: String
    var creatorName: String
    var creatorAvatar: String
    var date: String
    var passengers: [String]
}

var rideList = [
    RideModel(description: "Ride number 1", startPoint: "Espoo, Karaportti 2", finishPoint: "Helsinki, Aleksanterinkatu 1", creatorName: "Mika", creatorAvatar: "driver", date: "11.11.2022", passengers: []),
    RideModel(description: "Ride number 2", startPoint: "Vantaa, Vantaankuja 32", finishPoint: "Espoo, Espoonkatu 21", creatorName: "Pekka", creatorAvatar: "driver", date: "21.11.2022", passengers: []),
    RideModel(description: "Ride number 3", startPoint: "Helsinki, Helsinginkatu 5", finishPoint: "Vantaa, Vantaankatu 1 1", creatorName: "Liisa", creatorAvatar: "driver", date: "01.12.2022", passengers: []),
    RideModel(description: "Ride number 1", startPoint: "Espoo, Karaportti 2", finishPoint: "Helsinki, Aleksanterinkatu 1", creatorName: "Mika", creatorAvatar: "driver", date: "11.11.2022", passengers: []),
    RideModel(description: "Ride number 2", startPoint: "Vantaa, Vantaankuja 32", finishPoint: "Espoo, Espoonkatu 21", creatorName: "Pekka", creatorAvatar: "driver", date: "21.11.2022", passengers: []),
    RideModel(description: "Ride number 3", startPoint: "Helsinki, Helsinginkatu 5", finishPoint: "Vantaa, Vantaankatu 1 1", creatorName: "Liisa", creatorAvatar: "driver", date: "01.12.2022", passengers: []),
    RideModel(description: "Ride number 1", startPoint: "Espoo, Karaportti 2", finishPoint: "Helsinki, Aleksanterinkatu 1", creatorName: "Mika", creatorAvatar: "driver", date: "11.11.2022", passengers: []),
    RideModel(description: "Ride number 2", startPoint: "Vantaa, Vantaankuja 32", finishPoint: "Espoo, Espoonkatu 21", creatorName: "Pekka", creatorAvatar: "driver", date: "21.11.2022", passengers: []),
    RideModel(description: "Ride number 3", startPoint: "Helsinki, Helsinginkatu 5", finishPoint: "Vantaa, Vantaankatu 1 1", creatorName: "Liisa", creatorAvatar: "driver", date: "01.12.2022", passengers: [])
]
