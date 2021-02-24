//
//  ContentView.swift
//  HM5_EmployeeList
//
//  Created by Oleg Krikun on 24.02.2021.
//

import SwiftUI

struct ContentView: View {
    private let employees = Employee.generationEmployees()
    
    var body: some View {
        TabView {
            EmployeesList(employees: employees)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Employees list")
                }
            DetailEmpoyeesList(employees: employees)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Detail list")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
