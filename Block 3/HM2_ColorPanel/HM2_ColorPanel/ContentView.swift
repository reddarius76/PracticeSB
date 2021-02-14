//
//  ContentView.swift
//  HM2_ColorPanel
//
//  Created by Oleg Krikun on 14.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var redColor: Double = 255
    @State private var greenColor: Double = 255
    @State private var blueColor: Double = 255
    
    var body: some View {
        ZStack {
            Color(.brown)
                .ignoresSafeArea()
            VStack {
                ColorPanel(red: $redColor, green: $greenColor, blue: $blueColor)
                ColorSlider(value: $redColor, color: .red)
                ColorSlider(value: $greenColor, color: .green)
                ColorSlider(value: $blueColor, color: .blue)
                Spacer()
            }
            .padding()
        }
    }
}

struct ColorPanel: View {
    @Binding var red: Double
    @Binding var green: Double
    @Binding var blue: Double
    
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

struct ColorSlider: View {
    @Binding var value: Double
    let color: Color

    var body: some View {
        let valueProxy = Binding<String>(
                    get: { String(format: "%.00f", Double(value)) },
                    set: { if let value = NumberFormatter().number(from: $0) {
                            self.value = value.doubleValue
                        }
                    }
                )
        
        HStack {
            Text("\(lround(value))")
                .foregroundColor(.white)
                .frame(width: 32)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(color)
            TextField("", text: valueProxy)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 48)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
