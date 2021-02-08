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
        
        let addSubtask = UIBarButtonItem(barButtonSystemItem: .add,
                                      target: self,
                                      action: #selector(addSubtaskPressed))
        navigationItem.rightBarButtonItem = addSubtask
    }
    
    @objc func addSubtaskPressed() {
        showAlert()
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
        let subtask = currentSubtasks[indexPath.row]
        
        //MARK: - Swipe Done subtask
        let doneDone = UIContextualAction(style: .destructive,
                                           title: "Done") { (action, view, success) in
            StorageDBManager.shared.edit(subtask: subtask, newValues: ["isDone": "true"])
            let newIndexPath = IndexPath(row: self.completedSubtasks.count - 1, section: 1)
            tableView.moveRow(at: indexPath, to: newIndexPath)
        }
        doneDone.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.768627451, blue: 0.1019607843, alpha: 1)
        return UISwipeActionsConfiguration(actions: [doneDone])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let subtask = indexPath.section == 0 ? currentSubtasks[indexPath.row] : completedSubtasks[indexPath.row]
        
        //MARK: - Swipe Edit subtask
        let editAction = UIContextualAction(style: .normal,
                                           title: "Edit") { (action, view, success) in
            self.showAlert(subtask: subtask) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        editAction.backgroundColor = #colorLiteral(red: 0, green: 0.5751428604, blue: 1, alpha: 1)
        
        //MARK: - Swipe Delete subtask
        let deleteAction = UIContextualAction(style: .destructive,
                                             title: "Delete") { (action, view, success) in
            StorageDBManager.shared.delete(subtask: subtask)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3098039216, alpha: 1)
        
        let conf = UISwipeActionsConfiguration (actions: [deleteAction, editAction])
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
}

extension SubtasksTableViewController {
    private func showAlert(subtask: Subtask? = nil, completion: (() -> Void)? = nil) {
        
        let title = subtask != nil ? "Update subtask" : "New subtask"
        
        let alert = AlertController(
            title: title,
            message: "What do you want to do?",
            preferredStyle: .alert
        )
        
        alert.action(for: subtask) { name, note in
            //MARK: - Edit subtask
            if let subtask = subtask, let completion = completion  {
                let subtaskData = ["name": name, "note": note]
                StorageDBManager.shared.edit(subtask: subtask, newValues: subtaskData)
                completion()
            } else {
                //MARK: - Add new subtask
                let subtask = Subtask()
                subtask.name = name
                subtask.note = note
                StorageDBManager.shared.add(subtask: subtask, in: self.task)
                let rowIndex = IndexPath(row: self.currentSubtasks.count - 1, section: 0)
                self.tableView.insertRows(at: [rowIndex], with: .automatic)
            }
        }
        present(alert, animated: true)
    }
}
