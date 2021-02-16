//
//  TextFieldName.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct TextFieldName: View {
    @Binding var valueText: String
    
    var body: some View {
        TextField("Enter your name", text: $valueText)
            .multilineTextAlignment(.leading)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 200, height: 40)
            .disableAutocorrection(true)
    }
}

struct TextFieldName_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldName(valueText: .constant("User"))
    }
}
