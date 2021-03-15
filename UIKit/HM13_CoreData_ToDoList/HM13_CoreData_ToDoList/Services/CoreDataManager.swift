//
//  CoreDataManager.swift
//  HM13_CoreData_ToDoList
//
//  Created by Oleg Krikun on 31.01.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data createData support
    func createData(taskName: String) -> Task? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task",
                                                                 in: context)
        else { return nil }
        
        guard let task = NSManagedObject(entity: entityDescription,
                                         insertInto: context) as? Task
        else { return nil }
        
        task.name = taskName
        task.isDone = false
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
                return nil
            }
        }
        
        return task
    }
    
    // MARK: - Core Data retrieveData support
    func retrieveData(entity: String) -> [Any?] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        var tasks = [Any]()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error {
            print(error)
            return [nil]
        }
        
        return tasks
    }
    
    // MARK: - Core Data updateData support
    func updateData(entity: String, taskName: [String], isDone: Bool) -> [Task?] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "name == %@" , taskName.first!)
        do {
            let objs = try context.fetch(fetchRequest)
            var updatedTasks = [Task]()
            for objToUpdate in objs as! [Task] {
                objToUpdate.name = taskName.last
                objToUpdate.isDone = isDone
                updatedTasks.append(objToUpdate)
                print(updatedTasks)
            }
            do {
                try context.save()
            }
            return updatedTasks
        } catch let error {
            print(error)
            return [nil]
        }
    }
    
    // MARK: - Core Data deleteData support
    func deleteData(taskName: String) -> [Task?] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "name == %@" , taskName)
        do {
            let objs = try context.fetch(fetchRequest)
            var removedTasks = [Task]()
            for objToDelete in objs {
                context.delete(objToDelete)
                try context.save()
                removedTasks.append(objToDelete as! Task)
            }
            return removedTasks
        } catch let error {
            print(error)
            return [nil]
        }
    }
    
    // MARK: - Core Data saveContext support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }

    private init() {}
}

