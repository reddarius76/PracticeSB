//
//  AuthViewController.swift
//  HM_2.4
//
//  Created by Oleg Krikun on 07.01.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let auth = Auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.delegate = self
        passwordTextField.delegate = self

        loginButton.layer.cornerRadius = 3
    }
    
    //Transfer data to another View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let appUITBC = segue.destination as? AppUITabBarController else { return }
        guard let destinationVC = appUITBC.viewControllers?.first as? UserViewController else { return }
        destinationVC.userName = userTextField.text
    }
    
    @IBAction func loginButtonAction() {
        guard let userText = userTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        if userText == auth.user && passwordText == auth.password {
            //Open another View with help of Button
            performSegue(withIdentifier: "authInApp", sender: nil)
        } else if userText == "" || passwordText == "" {
            showAlert(with: ErrorAlert.getErrorAlertForEnterLoginAndPassword().title.rawValue,
                      and: ErrorAlert.getErrorAlertForEnterLoginAndPassword().message.rawValue,
                      type: ErrorAlert.getErrorAlertForEnterLoginAndPassword().alertType)
        } else if userText != auth.user && passwordText == auth.password {
            showAlert(with: ErrorAlert.getErrorAlertForInvalidLogin().title.rawValue,
                      and: ErrorAlert.getErrorAlertForInvalidLogin().message.rawValue,
                      type: ErrorAlert.getErrorAlertForInvalidLogin().alertType)
        } else if userText == auth.user && passwordText != auth.password {
            showAlert(with: ErrorAlert.getErrorAlertForInvalidPassword().title.rawValue,
                      and: ErrorAlert.getErrorAlertForInvalidPassword().message.rawValue,
                      type: ErrorAlert.getErrorAlertForInvalidPassword().alertType)
        } else if userText != auth.user && passwordText != auth.password {
            showAlert(with: ErrorAlert.getErrorAlertForInvalidLoginOrPassword().title.rawValue,
                      and: ErrorAlert.getErrorAlertForInvalidLoginOrPassword().message.rawValue,
                      type: ErrorAlert.getErrorAlertForInvalidLoginOrPassword().alertType)
        }
    }
    
    @IBAction func forgotUser() {
        showAlert(with: ErrorAlert.getErrorAlertForForgotLogin().title.rawValue,
                  and: ErrorAlert.getErrorAlertForForgotLogin().message.rawValue,
                  type: ErrorAlert.getErrorAlertForForgotLogin().alertType)
    }
    
    @IBAction func forgotPassword() {
        showAlert(with: ErrorAlert.getErrorAlertForForgotPassword().title.rawValue,
                  and: ErrorAlert.getErrorAlertForForgotPassword().message.rawValue,
                  type: ErrorAlert.getErrorAlertForForgotPassword().alertType)
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        userTextField.text = nil
        passwordTextField.text = nil
        
    }
    
    deinit {
        print("AuthViewController has been deallocated")
    }
}

extension AuthViewController {
    private func showAlert(with title: String, and message: String, type: AlertType) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var okAction = UIAlertAction()
        switch type {
        case .inputLoginError:
            okAction = UIAlertAction(title: "Ok", style: .default) {_ in self.passwordTextField.text = ""
            }
        case .forgotError: okAction = UIAlertAction(title: "Ok", style: .default)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension AuthViewController: UITextFieldDelegate {
    // Hide keyboard when tap on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //Work with Next and Done in keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            loginButtonAction()
        }
        return false
    }
}
