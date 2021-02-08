//
//  AlertController.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 07.02.2021.
//

import UIKit

class AlertController: UIAlertController {
    //MARK: - Action for task
    func action(for task: Task? = nil, completion: @escaping (String) -> Void) {
        let doneButton = task == nil ? "Save" : "Edit"
        let doneAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let name = self.textFields?.first?.text else { return }
            guard !name.isEmpty else { return }
            completion(name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(doneAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Task"
            textField.text = task?.name
        }
    }
    
    //MARK: - Action for subtask
    func action(for subtask: Subtask? = nil, completion: @escaping (String, String) -> Void) {
        let doneButton = subtask == nil ? "Save" : "Edit"
        let doneAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let name = self.textFields?.first?.text else { return }
            guard !name.isEmpty else { return }
            if let note = self.textFields?.last?.text, !note.isEmpty {
                completion(name, note)
            } else {
                completion(name, "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(doneAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Subtask"
            textField.text = subtask?.name
        }
        addTextField { textField in
            textField.placeholder = "Description"
            textField.text = subtask?.note
        }
    }

}
