//
//  CounterValidation.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct CounterValidation: View {
    let valueName: String
    let colorCounter: Color
    
    var body: some View {
        Text("\(valueName.count)")
            .frame(width: 32, height: 40)
            .foregroundColor(colorCounter)
    }
}

struct CounterValidation_Previews: PreviewProvider {
    static var previews: some View {
        CounterValidation(valueName: "01", colorCounter: .red)
    }
}
