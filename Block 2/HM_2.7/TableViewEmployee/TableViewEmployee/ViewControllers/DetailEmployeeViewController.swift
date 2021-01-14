//
//  DetailEmployeeViewController.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

import UIKit

class DetailEmployeeViewController: UIViewController {
    

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var employee: Person! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = employee.fullname

        phoneLabel.text = "Phone: " + employee.phone
        emailLabel.text = "Email: " + employee.email
    }
}
