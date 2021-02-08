//
//  TasksTableViewController.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 06.02.2021.
//

import UIKit
import RealmSwift

class TasksTableViewController: UITableViewController {
    let tasks = StorageDBManager.shared.getData()
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        currentTasks = tasks.filter("isDone = false")
        completedTasks = tasks.filter("isDone = true")
        
        let addTask = UIBarButtonItem(barButtonSystemItem: .add,
                                      target: self,
                                      action: #selector(addTaskPressed))
        navigationItem.rightBarButtonItem = addTask
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let task = currentTasks[indexPath.row]
        let subtasksTVC = segue.destination as! SubtasksTableViewController
        subtasksTVC.task = task
        clearsSelectionOnViewWillAppear = true
    }
    
    @objc func addTaskPressed() {
        showAlert()
    }
}

// MARK: - Table view data source
extension TasksTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath)
        let task = currentTasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        content.secondaryText = "\(task.subtasks.filter("isDone = false").count)"
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Table view Swipe
extension TasksTableViewController {
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = currentTasks[indexPath.row]
        
        //MARK: - Swipe Done task
        let doneAction = UIContextualAction(style: .destructive,
                                           title: "Done") { (action, view, success) in
            StorageDBManager.shared.edit(task: task, newValues: ["isDone": "true"])
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        doneAction.backgroundColor = #colorLiteral(red: 0.3215686275, green: 0.768627451, blue: 0.1019607843, alpha: 1)
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = currentTasks[indexPath.row]
        
        //MARK: - Swipe Edit task
        let editAction = UIContextualAction(style: .normal,
                                           title: "Edit") { (action, view, success) in
            self.showAlert(task: task) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        editAction.backgroundColor = #colorLiteral(red: 0, green: 0.5751428604, blue: 1, alpha: 1)
        
        //MARK: - Swipe Delete task
        let deleteAction = UIContextualAction(style: .destructive,
                                             title: "Delete") { (action, view, success) in
            StorageDBManager.shared.delete(task: task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.3019607843, blue: 0.3098039216, alpha: 1)
        
        let conf = UISwipeActionsConfiguration (actions: [deleteAction, editAction])
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
}

// MARK: - Alert Controller
extension TasksTableViewController {
    
    private func showAlert(task: Task? = nil, completion: (() -> Void)? = nil) {
        
        let title = task != nil ? "Update task" : "New task"
        
        let alert = AlertController(
            title: title,
            message: "What do you want to do?",
            preferredStyle: .alert
        )
        
        alert.action(for: task) { name in
            //MARK: - Edit task
            if let task = task, let completion = completion {
                StorageDBManager.shared.edit(task: task, newValues: ["name": name])
                completion()
            } else {
                //MARK: - Add new task
                let task = Task()
                task.name = name
                StorageDBManager.shared.add(task: task)
                let rowIndex = IndexPath(row: self.currentTasks.count - 1, section: 0)
                self.tableView.insertRows(at: [rowIndex], with: .automatic)
            }
        }
        present(alert, animated: true)
    }
}
