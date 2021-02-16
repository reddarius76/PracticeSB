//
//  ContentView.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: UserManager
    
    var body: some View {
        Group {
            if user.isLogin {
                TimerView()
            } else {
                AuthView()
            }
        }.onAppear(perform: { user.checkUserSettings() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserManager())
    }
}
