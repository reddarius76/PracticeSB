//
//  ContentView.swift
//  HM1_TrafficLight
//
//  Created by Oleg Krikun on 13.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var currentLight = CurrentLight.red
    private let lightOff: CGFloat = 0.3
    private let lightOn: CGFloat = 1
    @State private var redLight = Light(color: .red, alpha: 0.3)
    @State private var yellowLight = Light(color: .yellow, alpha: 0.3)
    @State private var greenLight = Light(color: .green, alpha: 0.3)
    @State private var textButton = "Start"
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                redLight
                yellowLight
                greenLight
                Spacer()
                Button(textButton) {
                    switch currentLight {
                    case .red:
                        greenLight.alpha = lightOff
                        redLight.alpha = lightOn
                        currentLight = .yellow
                        textButton = "Next"
                    case .yellow:
                        redLight.alpha = lightOff
                        yellowLight.alpha = lightOn
                        currentLight = .green
                    case .green:
                        print("green")
                        yellowLight.alpha = lightOff
                        greenLight.alpha = lightOn
                        currentLight = .red
                    }
                }.font(.largeTitle)
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
