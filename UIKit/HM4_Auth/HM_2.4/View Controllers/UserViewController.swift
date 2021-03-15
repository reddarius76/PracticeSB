//
//  UserViewController.swift
//  HM_2.4
//
//  Created by Oleg Krikun on 07.01.2021.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = "Welcome, " + userName + "!"
        descriptionLable.text = "Tell me more about " + userName + "."
    }

    @IBAction func logoutAction() {
        //dismiss(animated: true)
    }
    
    deinit {
        print("UserViewController has been deallocated")
    }
}
