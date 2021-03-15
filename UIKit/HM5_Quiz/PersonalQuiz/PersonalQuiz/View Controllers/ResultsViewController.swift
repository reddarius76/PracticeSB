//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Oleg Krikun on 09.01.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var titleResultLabel: UILabel!
    @IBOutlet weak var messageResultLabel: UILabel!
    
    var resultQuiz: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        updateUI()
    }

}

extension ResultsViewController {
    private func updateUI() {
        let resultTexts = calcResult(resultQuiz: resultQuiz)
        titleResultLabel.text =  "Вы - " + String(resultTexts.rawValue) + "!"
        messageResultLabel.text = resultTexts.definition
    }
    
    private func calcResult(resultQuiz: [Answer]) -> AnimalType {
        var dogCount = 0
        var catCount = 0
        var rabbitCount = 0
        var turtleCount = 0
        var arrayCounts = [AnimalType: Int]()
        
        for result in resultQuiz {
            switch result.type {
            case .dog:
                dogCount += 1
                arrayCounts.updateValue(dogCount, forKey: .dog)
            case .cat:
                catCount += 1
                arrayCounts.updateValue(catCount, forKey: .cat)
            case .rabbit:
                rabbitCount += 1
                arrayCounts.updateValue(rabbitCount, forKey: .rabbit)
            case .turtle:
                turtleCount += 1
                arrayCounts.updateValue(turtleCount, forKey: .turtle)
            }
        }
        
        let result = arrayCounts.max { a, b in a.value < b.value }
        return result!.key
    }
}
