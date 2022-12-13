//
//  ViewModifiers.swift
//  sharemyway
//
//  Created by J.A. on 13.12.2022.
//

import Foundation
import SwiftUI

struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("CardBgrColor"))
            .padding(5)
            .foregroundColor(Color("AppExtraColor"))
    }
}

struct ViewModifiers_Previews: PreviewProvider {
    static var previews: some View {
        Text("test").modifier(CustomButton())
    }
}
