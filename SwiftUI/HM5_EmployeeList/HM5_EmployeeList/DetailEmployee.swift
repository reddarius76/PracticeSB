//
//  DetailEmployee.swift
//  HM5_EmployeeList
//
//  Created by Oleg Krikun on 24.02.2021.
//

import SwiftUI

struct DetailEmployee: View {
    let employee: Employee
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Phone: \(employee.phone)")
                Spacer()
            }
            HStack {
                Text("E-mail: \(employee.email)")
                Spacer()
            }
            Spacer()
        }
        .navigationBarTitle("\(employee.fullname)")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct DetailEmployee_Previews: PreviewProvider {
    static var previews: some View {
        DetailEmployee(employee: Employee.generationEmployees().first!)
    }
}
