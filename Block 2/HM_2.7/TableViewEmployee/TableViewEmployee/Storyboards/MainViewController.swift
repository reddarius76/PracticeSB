//
//  MainViewController.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    let persons = Person.generationPersons().shuffled()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let employeesListVC = viewControllers?.first as! EmployeesListViewController
        let infoListVC = viewControllers?.last as! InfoListViewController
        employeesListVC.employeesList = persons
        infoListVC.employeesList = persons
    }
}
