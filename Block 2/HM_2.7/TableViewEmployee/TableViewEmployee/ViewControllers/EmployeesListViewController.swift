//
//  EmployeesListViewController.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

import UIKit

class EmployeesListViewController: UITableViewController {

    var employeesList: [Person]!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailEmployeeVC = segue.destination as! DetailEmployeeViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        detailEmployeeVC.employee = employeesList[indexPath.row]
    }

}

// MARK: - Table view data source
extension EmployeesListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmployee", for: indexPath)
        let person = employeesList[indexPath.row]
        cell.textLabel?.text = person.fullname
        cell.textLabel?.numberOfLines = 0

        return cell
    }
}
