//
//  InfoListViewController.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

import UIKit

class InfoListViewController: UITableViewController {

    var employeesList: [Person]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        employeesList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .systemGray5
        label.textAlignment = .center
        let person = employeesList[section]
        label.text = person.fullname
        return label
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetailPhone", for: indexPath)
        
        let person = employeesList[indexPath.section]
    
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = person.phone
            cell.imageView?.image = UIImage(systemName: "phone")
        default:
            cell.textLabel?.text = person.email
            cell.imageView?.image = UIImage(systemName: "tray")
        }
        return cell
    }
    
    
}
