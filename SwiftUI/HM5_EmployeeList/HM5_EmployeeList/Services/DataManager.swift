//
//  DataManager.swift
//  TableViewEmployee
//
//  Created by Oleg Krikun on 13.01.2021.
//

class DataManager {
    
    static let shared = DataManager()
    
    let names = ["Alex", "Andrew", "Olga", "Anna", "Tom", "Rick", "Ura", "John"]
    let surnames = ["Kan", "Shlupp", "Ra", "Cook", "Yoker", "Sanchez", "Petrov", "Wick"]
    let phones = ["89998889988", "80008889977", "86668887788", "81118883322", "83338887766", "83335557711", "83335857722", "83335851812"]
    let emails = ["z@a.com", "x@b.com", "o@c.com", "p@d.com", "l@e.com", "k@f.com", "i@g.com", "h@g.com"]
    
    private init() {}
}
