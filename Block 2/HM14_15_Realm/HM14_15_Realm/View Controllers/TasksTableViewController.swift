//
//  TasksTableViewController.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 06.02.2021.
//

import UIKit

class TasksTableViewController: UITableViewController {
    let tasks = StorageDBManager.shared.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let task = tasks![indexPath.row]
        let subtasksTVC = segue.destination as! SubtasksTableViewController
        subtasksTVC.task = task
        clearsSelectionOnViewWillAppear = true
    }
}

// MARK: - Table view data source
extension TasksTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath)
        let task = tasks![indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Table view Swipe
extension TasksTableViewController {
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeDone = UIContextualAction(style: .destructive,
                                           title: "Done") { (action, view, success) in
        }
        swipeDone.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return UISwipeActionsConfiguration(actions: [swipeDone])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeEdit = UIContextualAction(style: .normal,
                                           title: "Edit") { (action, view, success) in
        }
        swipeEdit.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let swipeDelete = UIContextualAction(style: .destructive,
                                             title: "Delete") { (action, view, success) in
        }
        swipeDelete.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        let conf = UISwipeActionsConfiguration (actions: [swipeDelete, swipeEdit])
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
}
