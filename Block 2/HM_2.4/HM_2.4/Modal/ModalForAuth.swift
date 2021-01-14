//
//  ModalForAuth.swift
//  HM_2.4
//
//  Created by Oleg Krikun on 07.01.2021.
//

struct Auth {
    var user: String {
        return "User"
    }
    var password: String {
        return "password"
    }
}

enum AlertType {
    case inputLoginError
    case forgotError
}

enum AlertName: String {
    case invalidLogin = "Invalid login."
    case invalidPassword = "Invalid password."
    case invalidLoginOrPassword = "Invalid login or password."
    case enterLoginAndPassword = "Enter your login and password."
    case forgotLogin = "Your User is User."
    case forgotPassword = "Your Password is password."
}

enum AlertTitle: String {
    case loginErrorTitle = "Warning!"
    case forgotErrorTitle = "Ooops!"
}

struct ErrorAlert {
    let title: AlertTitle
    let message: AlertName
    let alertType: AlertType
}

extension ErrorAlert {
    static func getErrorAlertForInvalidLogin() -> ErrorAlert {
        return ErrorAlert(title: .loginErrorTitle, message: .invalidLogin, alertType: .inputLoginError)
    }
    
    static func getErrorAlertForInvalidPassword() -> ErrorAlert {
        return ErrorAlert(title: .loginErrorTitle, message: .invalidPassword, alertType: .inputLoginError)
    }
    
    static func getErrorAlertForInvalidLoginOrPassword() -> ErrorAlert {
        return ErrorAlert(title: .loginErrorTitle, message: .invalidLoginOrPassword, alertType: .inputLoginError)
    }
    
    static func getErrorAlertForEnterLoginAndPassword() -> ErrorAlert {
        return ErrorAlert(title: .loginErrorTitle, message: .enterLoginAndPassword, alertType: .inputLoginError)
    }
    
    static func getErrorAlertForForgotLogin() -> ErrorAlert {
        return ErrorAlert(title: .forgotErrorTitle, message: .forgotLogin, alertType: .forgotError)
    }
    
    static func getErrorAlertForForgotPassword() -> ErrorAlert {
        return ErrorAlert(title: .forgotErrorTitle, message: .forgotPassword, alertType: .forgotError)
    }
}
