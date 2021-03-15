//
//  HM3_TimerApp.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

@main
struct HM3_TimerApp: App {
    private let user = StorageManager.shared.fetchUserSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserManager(user: user))
        }
    }
}
