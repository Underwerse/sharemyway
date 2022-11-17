//
//  MapView.swift
//  sharemyway
//
//  Created by iosdev on 17.11.2022.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            Color.blue
            
            Image(systemName: "map.fill")
                .foregroundColor(Color.white)
                .font(.system(size: 100))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
