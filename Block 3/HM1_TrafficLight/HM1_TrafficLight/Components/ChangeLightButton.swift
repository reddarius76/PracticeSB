//
//  ChangeLightButton.swift
//  HM1_TrafficLight
//
//  Created by Oleg Krikun on 13.02.2021.
//

import SwiftUI

struct ChangeLightButton: View {
    let title: String
    let comletion: () -> Void
    
    var body: some View {
        Button(action: comletion) {
            Text(title)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
        }
        .padding()
        .frame(width: 150, height: 60)
        .background(Color.white)
        .cornerRadius(25)
        .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                    .stroke(Color.blue, lineWidth: 2))
    }
}

struct ChangeLightButton_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLightButton(title: "Start", comletion: {})
    }
}
