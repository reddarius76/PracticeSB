//
//  ButtonLogout.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct ButtonLogout: View {
    @EnvironmentObject var user: UserManager
    
    var body: some View {
        Button(action: logout) {
            Text("Logout")
                .frame(width: 150, height: 50)
                .font(.title)
                .foregroundColor(.red)
                .background(Color(.white))
                .cornerRadius(10)
        }
    }
}

extension ButtonLogout {
    private func logout() {
        StorageManager.shared.resetUserSettings()
        user.checkUserSettings()
    }
}

struct ButtonLogout_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLogout()
            .environmentObject(UserManager())
    }
}

