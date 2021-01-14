//
//  DataManager.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    let names = ["Alex", "Andrew", "Olga", "Anna", "Tom"]
    let surnames = ["Kan", "Shlupp", "Ra", "Cook", "Yoker"]
    let phones = ["89998889988", "80008889977", "86668887788", "81118883322", "83338887766"]
    let emails = ["a@a.com", "b@b.com", "c@c.com", "d@d.com", "e@e.com"]
    
    private init() {}
}
