//
//  TextCounterTimer.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct TextCounterTimer: View {
    @StateObject var timer: TimerCounter
    
    var body: some View {
        Text("\(timer.counter)")
            .frame(width: 50, height: 50)
            .font(.largeTitle)
            .offset(x: 0, y: -36.0)
    }
}

struct TextCounterTimer_Previews: PreviewProvider {
    static var previews: some View {
        TextCounterTimer(timer: TimerCounter())
    }
}

