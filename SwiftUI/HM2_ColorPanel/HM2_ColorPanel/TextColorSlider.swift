//
//  TextColorSlider.swift
//  HM2_ColorPanel
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct TextColorSlider: View {
    let value: Double
    
    var body: some View {
        Text("\(lround(value))")
            .foregroundColor(.white)
            .frame(width: 32)
    }
}

struct TextColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        TextColorSlider(value: 15.0)
    }
}
