//
//  ColorSlider.swift
//  HM2_ColorPanel
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    let color: Color

    var body: some View {
        HStack {
            TextColorSlider(value: value)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
            TextFieldColorSlider(value: $value)
        }
    }
}

struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorSlider(value: .constant(25.0), color: .pink)
    }
}
