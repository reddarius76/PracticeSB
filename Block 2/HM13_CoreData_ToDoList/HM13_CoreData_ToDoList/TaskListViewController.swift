//
//  ViewController.swift
//  HM13_CoreData_ToDoList
//
//  Created by Oleg Krikun on 31.01.2021.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController  {
    
    private let cellID = "cell"
    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 60
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let fetchTasks = CoreDataManager.shared.retrieveData(entity: "Task") as? [Task] else { return }
        
        for task in fetchTasks {
            if task.isDone == false {
                self.tasks.append(task)
            }
        }
    }
    
    private func save(taskName: String) {
        guard let taskNew = CoreDataManager.shared.createData(taskName: taskName) else { return }
        tasks.append(taskNew)
        let cellIndex = IndexPath(row: tasks.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
    
    private func delete(taskId: Int) {
        guard CoreDataManager.shared.deleteData(taskName: tasks[taskId].name ?? "") != [nil] else { return }
        tasks.remove(at: taskId)
        let cellIndex = IndexPath(row: taskId, section: 0)
        tableView.deleteRows(at: [cellIndex], with: .automatic)
    }
    
    private func update(taskId: Int, taskName: [String], isDone: Bool) {
        guard CoreDataManager.shared.updateData(entity: "Task", taskName: taskName, isDone: isDone) != [nil] else { return }
        self.tasks[taskId].name = taskName.last
        self.tasks[taskId].isDone = isDone
        
        if isDone == true {
            self.tasks.remove(at: taskId)
            let cellIndex = IndexPath(row: taskId, section: 0)
            tableView.deleteRows(at: [cellIndex], with: .automatic)
        } else if isDone == false {
            let cellIndex = IndexPath(row: taskId, section: 0)
            tableView.reloadRows(at: [cellIndex], with: .automatic)
        }
    }
}

//MARK: - Table view data source
extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = tasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeDone = UIContextualAction(style: .destructive,
                                           title: "Done") { (action, view, success) in
            self.update(taskId: indexPath.row, taskName: [self.tasks[indexPath.row].name!, self.tasks[indexPath.row].name!], isDone: true)
        }
        swipeDone.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return UISwipeActionsConfiguration(actions: [swipeDone])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let index = indexPath.row
        let swipeEdit = UIContextualAction(style: .normal,
                                           title: "Edit") { (action, view, success) in
            self.editTask(idTask: index)
        }
        swipeEdit.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let swipeDelete = UIContextualAction(style: .destructive,
                                             title: "Delete") { (action, view, success) in
            self.deleteTask(idTask: index)
        }
        swipeDelete.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        let conf = UISwipeActionsConfiguration (actions: [swipeDelete, swipeEdit])
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
}

//MARK: - setupNavigationBar
extension TaskListViewController {
    private func setupNavigationBar() {
        title = "ToDo List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 1
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
    }
}

//MARK: - Alert
extension TaskListViewController {
    
    @objc private func addNewTask() {
        showAlertForAdd(
            withTitle: "Add new task",
            andMessage: "What do you want to do?")
    }
    
    private func editTask(idTask: Int) {
        showAlertForEdit(
            withTitle: "Edit task",
            andMessage: "What was changed?",
            idTask: idTask)
    }
    
    private func deleteTask(idTask: Int) {
        showAlertForDelete(
            withTitle: "Delete task!",
            andMessage: "Are you sure?",
            idTask: idTask)
    }
    
    private func showAlertForAdd(
        withTitle title: String,
        andMessage message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            self.save(taskName: task)
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func showAlertForEdit(withTitle title: String,
                                  andMessage message: String,
                                  idTask: Int) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let editAction = UIAlertAction(
            title: "Edit",
            style: .default) { _ in
            guard let taskName = alert.textFields?.first?.text, !taskName.isEmpty else { return }
            self.update(taskId: idTask, taskName: [self.tasks[idTask].name!, taskName], isDone: false)
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive)
        
        alert.addTextField { textField in
            textField.text = self.tasks[idTask].name
        }
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func showAlertForDelete(
        withTitle title: String,
        andMessage message: String,
        idTask: Int) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .default) { _ in
            self.delete(taskId: idTask)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}


