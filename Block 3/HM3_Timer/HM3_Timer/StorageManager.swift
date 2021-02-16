//
//  StorageManager.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 15.02.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "userDefaults"
    
    func save(userSetting: UserSetting) {
        var userSettings = fetchUserSettings()
        userSettings.islogin = userSetting.islogin
        userSettings.name = userSetting.name
        guard let data = try? JSONEncoder().encode(userSettings) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchUserSettings() -> UserSetting {
        let defaultUser = UserSetting(islogin: false, name: "")
        guard let data = userDefaults.object(forKey: key) as? Data else { return defaultUser }
        guard let userSettings = try? JSONDecoder().decode(UserSetting.self, from: data) else { return defaultUser }
        return userSettings
    }
    
    func resetUserSettings() {
        var userSettings = fetchUserSettings()
        userSettings.islogin = false
        userSettings.name = ""
        guard let data = try? JSONEncoder().encode(userSettings) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    private init() {}
}

struct UserSetting: Codable {
    var islogin: Bool
    var name: String
}
