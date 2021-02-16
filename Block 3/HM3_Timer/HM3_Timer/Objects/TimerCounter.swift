//
//  TimerCounter.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import Foundation
import Combine

class TimerCounter: ObservableObject {
    let objectWillChange = PassthroughSubject<TimerCounter, Never>()
    var counter = 3
    var timer: Timer?
    var titleButton = "Start"
    var isDisabled = false
    
    func startTimer() {
        if counter > 0 {
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(updateCounter),
                userInfo: nil,
                repeats: true
            )
        }
        buttonDidTapped()
    }
    
    @objc private func updateCounter() {
        if counter > 0 {
            counter -= 1
        } else {
            killTimer()
            titleButton = "Reset"
            isDisabled = false
        }
        
        objectWillChange.send(self)
    }
    
    private func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func buttonDidTapped() {
        if titleButton == "Reset" {
            counter = 3
            titleButton = "Start"
        } else {
            titleButton = "Wait..."
            isDisabled = true
        }
        
        objectWillChange.send(self)
    }
}
