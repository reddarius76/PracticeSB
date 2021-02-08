//
//  Task.swift
//  HM14_15_Realm
//
//  Created by Oleg Krikun on 06.02.2021.
//

import RealmSwift

class Subtask: Object {
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var isDone = false
    @objc dynamic var dateCreated = Date()
}

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var isDone = false
    @objc dynamic var dateCreated = Date()
    let subtasks = List<Subtask>()
}
