//
//  UserInfo.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import Combine

class UserManager: ObservableObject {
    @Published var user = User()
    
    func checkUserSettings() {
        let userSettings = StorageManager.shared.fetchUserSettings()
        self.user.islogin = userSettings.islogin
        self.user.name = userSettings.name
    }
    
    init() {}
    
    init(user: User) {
        self.user = user
    }
}

struct User: Codable {
    var islogin = false
    var name = ""
}
