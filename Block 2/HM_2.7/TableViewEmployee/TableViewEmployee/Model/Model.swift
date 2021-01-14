//
//  Modal.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

struct Person {
    let name: String
    let surname: String
    let phone: String
    let email: String
    
    var fullname: String {
        "\(name) \(surname)"
    }
}

extension Person {
    static func generationPersons() -> [Person] {
        var persons = [Person]()
        
        for i in 0..<DataManager.shared.names.count {
            persons.append(
                Person(name: DataManager.shared.names[i],
                       surname: DataManager.shared.surnames[i],
                       phone: DataManager.shared.phones[i],
                       email: DataManager.shared.emails[i]
                )
            )
        }
    return persons
    }
}


