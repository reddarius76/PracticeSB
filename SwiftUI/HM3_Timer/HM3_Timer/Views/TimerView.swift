//
//  SwiftUIView.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var timer = TimerCounter()
    
    var body: some View {
        ZStack {
            Color(.systemYellow).ignoresSafeArea()
            VStack {
                TextWelcome()
                Spacer()
                VStack {
                    TextCounterTimer(timer: timer)
                    ButtonTimer(timer: timer)
                }
                Spacer()
                ButtonLogout()
            }.padding()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
