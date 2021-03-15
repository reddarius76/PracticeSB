//
//  ContentView.swift
//  HM1_TrafficLight
//
//  Created by Oleg Krikun on 13.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var currentLight = CurrentLight.red
    @State private var buttonTitle = "Start"
    
    @State private var redLightState = 0.3
    @State private var yellowLightState = 0.3
    @State private var greenLightState = 0.3

    private func nextLight() {
        let lightOff = 0.3
        let lightOn = 1.0
        
        switch currentLight {
        case .red:
            currentLight = .yellow
            greenLightState = lightOff
            redLightState = lightOn
        case .yellow:
            currentLight = .green
            redLightState = lightOff
            yellowLightState = lightOn
        case .green:
            currentLight = .red
            yellowLightState = lightOff
            greenLightState = lightOn
        }
    }
}

extension ContentView {
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(spacing: 15) {
                LightView(color: .red, opacity: redLightState)
                LightView(color: .yellow, opacity: yellowLightState)
                LightView(color: .green, opacity: greenLightState)
                Spacer()
                ChangeLightButton(title: buttonTitle) {
                    buttonTitle = "Next"
                    nextLight()
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
