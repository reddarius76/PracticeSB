//
//  SubtasksTableViewController.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 06.02.2021.
//

import UIKit
import RealmSwift

class SubtasksTableViewController: UITableViewController {
    
    var task: Task!
    var currentSubtasks: Results<Subtask>!
    var completedSubtasks: Results<Subtask>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        title = task.name
        
        currentSubtasks = task.subtasks.filter("isDone = false")
        completedSubtasks = task.subtasks.filter("isDone = true")
    }
}

// MARK: - Table view data source
extension SubtasksTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? currentSubtasks.count : completedSubtasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Current subtasks" : "Completed subtasks"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubtask", for: indexPath)
        let subtask = indexPath.section == 0 ? currentSubtasks[indexPath.row] : completedSubtasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = subtask.name
        content.secondaryText = subtask.note
        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - Table view Swipe
extension SubtasksTableViewController {
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 { return nil }
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
