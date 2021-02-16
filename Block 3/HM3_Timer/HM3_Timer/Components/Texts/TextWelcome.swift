//
//  TextWelcome.swift
//  HM3_Timer
//
//  Created by Oleg Krikun on 16.02.2021.
//

import SwiftUI

struct TextWelcome: View {
    @EnvironmentObject var user: UserManager
    
    var body: some View {
        Text("Hi! \(user.name)")
            .frame(width: 350, height: 40)
            .font(.largeTitle)
    }
}

struct TextWelcome_Previews: PreviewProvider {
    static var previews: some View {
        TextWelcome()
            .environmentObject(UserManager())
    }
}
