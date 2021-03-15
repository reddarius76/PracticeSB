//
//  AuthView.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct AuthView: View {
    @State private var valueName = ""
    @State private var isDisabled = true
    @State private var colorCounter = Color(.red)
    
    var body: some View {
        ZStack {
            Color(.systemIndigo).ignoresSafeArea()
            VStack {
                HStack {
                    TextFieldName(valueText: valueText)
                    CounterValidation(
                        valueName: valueName,
                        colorCounter: colorCounter
                    )
                }
                ButtonLogin(
                    valueName: $valueName,
                    isDisabled: $isDisabled
                )
            }
        }
    }
}

extension AuthView {
    var valueText: Binding<String> {
        Binding<String>(
            get: { valueName },
            set: { valueName = $0
                if valueName.count > 2 {
                    self.isDisabled = false
                    self.colorCounter = Color(.green)
                } else {
                    self.isDisabled = true
                    self.colorCounter = Color(.red)
                }
            }
        )
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
