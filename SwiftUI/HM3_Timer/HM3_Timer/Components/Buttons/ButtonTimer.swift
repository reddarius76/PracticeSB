//
//  ButtonTimer.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct ButtonTimer: View {
    @StateObject var timer: TimerCounter
    
    var body: some View {
        Button(action: { timer.startTimer() }) {
            Text("\(timer.titleButton)")
                .frame(width: 150, height: 50)
                .font(.largeTitle)
                .background(Color(.white))
                .cornerRadius(10)
        }
        .disabled(timer.isDisabled)
    }
}

struct ButtonTimer_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTimer(timer: TimerCounter())
    }
}
