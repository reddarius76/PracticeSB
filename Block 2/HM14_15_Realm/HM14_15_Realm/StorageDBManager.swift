//
//  StorageDBManager.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 06.02.2021.
//

import RealmSwift

class StorageDBManager {
    static let shared = StorageDBManager()
    private var database: Realm?
    
    func addData(object: Task) {
        guard let database = database else { return }
        do {
            try database.write {
                database.add(object, update: .all)
            }
        } catch let error {
            print("Error addData to DB: \(error.localizedDescription)")
        }
    }
    
    func getData() -> Results<Task>? {
        guard let database = database else { return nil}
        let results = database.objects(Task.self)
        return results
    }
    
    func deleteData(object: Task) {
        guard let database = database else { return }
        do {
            try database.write {
                database.delete(object)
            }
        } catch let error {
            print("Error deleteData: \(error.localizedDescription)")
        }
    }
    
    func deletaAll() {
        guard let database = database else { return }
        do {
            try database.write {
                database.deleteAll()
            }
        } catch let error {
            print("Error deleteAll: \(error.localizedDescription)")
        }
    }
    
    private init() {
        do {
            database = try Realm()
        } catch let error {
            print("Error open DB: \(error.localizedDescription)")
        }
    }
}
