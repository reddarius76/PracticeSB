//
//  StorageDBManager.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 06.02.2021.
//

import RealmSwift

class StorageDBManager {
    static let shared = StorageDBManager()
    private let database = try! Realm()
    
    // MARK: - Task methods
    func add(task: Task) {
        write {
            database.add(task)
        }
    }
    
    func getData() -> Results<Task> {
        let results = database.objects(Task.self)
        return results
    }
    
    func edit(task: Task, newValues: [String: String]) {
        write {
            for newValue in newValues {
                switch newValue.key {
                case "name": task.name = newValue.value
                case "isDone": task.isDone = Bool(newValue.value) ?? true
                default: break
                }
            }
        }
    }
    
    func delete(task: Task) {
        write {
            let subtask = task.subtasks
            database.delete(subtask)
            database.delete(task)
        }
    }
    
    // MARK: - Subtask methods
    func add(subtask: Subtask, in task: Task) {
        write {
            task.subtasks.append(subtask)
        }
    }
    
    func edit(subtask: Subtask, newValues: [String: String]) {
        write {
            for newValue in newValues {
                switch newValue.key {
                case "name": subtask.name = newValue.value
                case "note": subtask.note = newValue.value
                case "isDone": subtask.isDone = Bool(newValue.value) ?? true
                default: break
                }
            }
            
        }
    }
    
    func delete(subtask: Subtask) {
        write {
            database.delete(subtask)
        }
    }
    
    
    // MARK: - Another methods
    func deletaAll() {
        write {
            database.deleteAll()
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try database.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
    
    private init() {}
}
