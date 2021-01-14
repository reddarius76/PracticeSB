//
//  ViewController.swift
//  HM_2.1.2
//
//  Created by Oleg Krikun on 31.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redSignalView: UIView!
    @IBOutlet weak var yellowSignalView: UIView!
    @IBOutlet weak var greenSignalView: UIView!
    @IBOutlet weak var button: UIButton!
    
    private var stateFlag = "start"
    private let lightOn: CGFloat = 1
    private let lightOff: CGFloat = 0.4
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSignalView.layer.cornerRadius = redSignalView.frame.size.width/2
        yellowSignalView.layer.cornerRadius =  yellowSignalView.frame.size.width/2
        greenSignalView.layer.cornerRadius =  greenSignalView.frame.size.width/2

    }

    @IBAction func startButton() {
        button.setTitle("Next", for: .normal)
        
        switch stateFlag {
        case "start":
            redSignalView.alpha = lightOn
            stateFlag = "red"
        case "red":
            yellowSignalView.alpha = lightOn
            redSignalView.alpha = lightOff
            stateFlag = "yellow"
        case "yellow":
            greenSignalView.alpha = lightOn
            yellowSignalView.alpha = lightOff
            stateFlag = "green"
        case "green":
            greenSignalView.alpha = lightOff
            button.setTitle("Start", for: .normal)
            stateFlag = "start"
        default:
            redSignalView.alpha = lightOff
            yellowSignalView.alpha = lightOff
            greenSignalView.alpha = lightOff
        }
    }
}

