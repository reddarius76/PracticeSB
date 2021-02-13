//
//  Light.swift
//  HM1_TrafficLight
//
//  Created by Oleg Krikun on 13.02.2021.
//

import SwiftUI

struct LightView: View {
    let color: Color
    let opacity: Double
    
    var body: some View {
        Circle()
            .frame(width: 150, height: 150)
            .foregroundColor(color)
            .opacity(opacity)
            .clipShape(Circle())
    }
}

struct Light_Previews: PreviewProvider {
    static var previews: some View {
        LightView(color: .black, opacity: 1)
    }
}

enum CurrentLight {
    case red, yellow, green
}
