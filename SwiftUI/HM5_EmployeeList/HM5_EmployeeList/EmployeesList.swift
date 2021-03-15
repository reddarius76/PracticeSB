//
//  EmployeesList.swift
//  HM5_EmployeeList
//
//  Created by Oleg Krikun on 24.02.2021.
//

import SwiftUI

struct EmployeesList: View {
    let employees: [Employee]
    
    var body: some View {
        NavigationView {
            List(employees, id: \.id) { employee in
                NavigationLink(destination: DetailEmployee(employee: employee)) {
                    Text("\(employee.fullname)")
                }
            }
            .navigationBarTitle("Employees List")
        }
    }
}

struct EmployeesList_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesList(employees: Employee.generationEmployees())
    }
}
