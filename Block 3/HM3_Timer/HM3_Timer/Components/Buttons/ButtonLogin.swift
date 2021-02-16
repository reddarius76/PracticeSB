//
//  ButtonLogin.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct ButtonLogin: View {
    @EnvironmentObject var user: UserManager
    @Binding var valueName: String
    @Binding var isDisabled: Bool
    
    var body: some View {
        Button(action: loginAction) {
            HStack {
                Image(systemName: "applelogo")
                Text("Login")
            }
            .frame(width: 96, height: 40)
            .background(Color(.white))
            .cornerRadius(5)
        }
        .disabled(isDisabled)
    }
}

extension ButtonLogin {
    private func loginAction() {
        if !valueName.isEmpty && valueName.count > 2 {
            let newUser = UserSetting(islogin: true, name: valueName)
            StorageManager.shared.save(userSetting: newUser)
            user.checkUserSettings()
        }
    }
}

struct ButtonLogin_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLogin(valueName: .constant("User"), isDisabled: .constant(true))
    }
}
