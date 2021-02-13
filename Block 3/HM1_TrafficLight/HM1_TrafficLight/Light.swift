//
//  Light.swift
//  HM1_TrafficLight
//
//  Created by Oleg Krikun on 13.02.2021.
//

import SwiftUI

struct Light: View {
    let color: UIColor
    var alpha: CGFloat
    var body: some View {
        Color(color.withAlphaComponent(alpha))
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke())
    }
}

struct Light_Previews: PreviewProvider {
    static var previews: some View {
        Light(color: .yellow, alpha: 1)
    }
}

enum CurrentLight {
    case red, yellow, green
}
