//
//  Employee.swift
//  HM5_EmployeeList
//
//  Created by Oleg Krikun on 24.02.2021.
//

struct Employee: Hashable {
    let id: Int
    let name: String
    let surname: String
    let phone: String
    let email: String
    
    var fullname: String {
        "\(name) \(surname)"
    }
}

extension Employee {
    static func generationEmployees() -> [Employee] {
        var employees = [Employee]()
        
        for i in 0..<DataManager.shared.names.count {
            employees.append(
                Employee(
                    id: i,
                    name: DataManager.shared.names[i],
                    surname: DataManager.shared.surnames[i],
                    phone: DataManager.shared.phones[i],
                    email: DataManager.shared.emails[i]
                )
            )
        }
    return employees
    }
}
