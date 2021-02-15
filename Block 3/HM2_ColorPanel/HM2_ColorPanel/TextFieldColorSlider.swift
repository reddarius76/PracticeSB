//
//  TextFieldColorSlider.swift
//  HM2_ColorPanel
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct TextFieldColorSlider: View {
    @State private var showAlert = false
    @Binding var value: Double
    
    var body: some View {
        TextField("", text: valueText)
            .keyboardType(.decimalPad)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 48)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Wrong format!"),
                      message: Text("Please enter value from 0 to 255")
                )
            }
    }
}

extension TextFieldColorSlider {
    var valueText: Binding<String> {
        Binding<String>(
            get: { "\(lround(value))" },
            set: { let newValue = $0
                    if let value = NumberFormatter().number(from: newValue) {
                        let valueDouble = value.doubleValue
                            if !(0...255).contains(valueDouble) {
                                showAlert = true
                                return
                            }
                        self.value = valueDouble
                    } else if newValue == "" {
                        return
                    } else {
                    showAlert = true
                    return
                }
            }
        )
    }
}

struct TextFieldColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldColorSlider(value: .constant(25.0))
    }
}
