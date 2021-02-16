//
//  UserInfo.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import Combine

class UserManager: ObservableObject {
    @Published var isLogin = false
    var name = ""
    
    func checkUserSettings() {
        let userSettings = StorageManager.shared.fetchUserSettings()
        self.isLogin = userSettings.islogin
        self.name = userSettings.name
    }
}
