//
//  ContentView.swift
//  HM2_ColorPanel
//
//  Created by Oleg Krikun on 14.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var redColor = Double.random(in: 0...255)
    @State private var greenColor = Double.random(in: 0...255)
    @State private var blueColor = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(.brown)
                .ignoresSafeArea()
            VStack {
                ColorPanel(red: redColor, green: greenColor, blue: blueColor)
                ColorSlider(value: $redColor, color: .red)
                ColorSlider(value: $greenColor, color: .green)
                ColorSlider(value: $blueColor, color: .blue)
                Spacer()
            }
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
