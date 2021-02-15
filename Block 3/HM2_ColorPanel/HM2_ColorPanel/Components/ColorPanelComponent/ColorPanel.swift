//
//  ColorPanel.swift
//  HM2_ColorPanel
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct ColorPanel: View {
    let red: Double
    let green: Double
    let blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(
                Color(red: red / 255,
                      green: green / 255,
                      blue: blue / 255
                )
            )
            .frame(width: 350, height: 150)
    }
}

struct ColorPanel_Previews: PreviewProvider {
    static var previews: some View {
        ColorPanel(red: 100, green: 100, blue: 100)
    }
}
