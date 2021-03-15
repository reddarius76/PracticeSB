//
//  DetailEmpoyeesList.swift
//  HM5_EmployeeList
//
//  Created by Oleg Krikun on 24.02.2021.
//

import SwiftUI

struct DetailEmpoyeesList: View {
    let employees: [Employee]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(employees, id: \.self) { employee in
                    Section(header: Text(employee.fullname)) {
                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(.blue)
                            Text("\(employee.phone)")
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "tray")
                                .foregroundColor(.blue)
                            Text("\(employee.email)")
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Employees List")
        }
    }
}

struct DetailEmpoyeesList_Previews: PreviewProvider {
    static var previews: some View {
        DetailEmpoyeesList(employees: Employee.generationEmployees())
    }
}
