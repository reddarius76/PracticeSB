//
//  MainViewController.swift
//  HW9_animation
//
//  Created by Oleg Krikun on 16.01.2021.
//

import Spring

class MainViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet var animationView: SpringView!
    @IBOutlet var runButtonText: SpringButton!

    @IBOutlet var presetLabel: UILabel!
    @IBOutlet var curveLabel: UILabel!
    @IBOutlet var forceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var delayLabel: UILabel!
    
    //MARK: Private properties
    private var animationPresets = [String]()
    private var animationCurves = [String]()
    private var countPressed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationPresets = enumarateAnimationPreset()
        animationCurves = enumarateAnimationCurve()

    }

    //MARK: IBAction
    @IBAction func runButton(_ sender: SpringButton) {
        resetText()
        
        if countPressed == animationPresets.count { countPressed = 0 }

        animationView.animation = animationPresets[countPressed]
        animationView.curve = animationCurves[countPressed]
        animationView.force = CGFloat(Double.random(in: 0.1..<1.5))
        animationView.duration = CGFloat(Double.random(in: 1..<3))
        animationView.delay = CGFloat(Double.random(in: 0..<0.5))
        animationView.animate()
        
        setText()
        runButtonText.setTitle("Run " + animationPresets[countPressed + 1], for: .normal)
        
        countPressed += 1
    }
}

//MARK: enumarate enum AnimationPreset and AnimationCurve
extension MainViewController {
    private func enumarateAnimationPreset() -> [String] {
        var animationPresets = [String]()
        for animation in Spring.AnimationPreset.self.allCases {
            animationPresets.append(animation.rawValue)
        }
       
        return animationPresets.shuffled()
    }
    
    private func enumarateAnimationCurve() -> [String] {
        var animationCurves = [String]()
        for animation in Spring.AnimationCurve.self.allCases {
            animationCurves.append(animation.rawValue)
        }
       
        return animationCurves.shuffled()
    }
}

//MARK: Output Text
extension MainViewController {
    private func setText() {
        presetLabel.text = "Preset: " + animationView.animation
        curveLabel.text = "Curve: " + animationView.curve
        forceLabel.text = "Force: " + String(format: "%.2f\n", Double(animationView.force))
        durationLabel.text = "Duration: " + String(format: "%.2f\n", Double(animationView.duration))
        delayLabel.text = "Delay: " + String(format: "%.2f\n", Double(animationView.delay))
    }
    
    private func resetText() {
        presetLabel.text = "Preset: "
        curveLabel.text = "Curve: "
        forceLabel.text = "Force: "
        durationLabel.text = "Duration: "
        delayLabel.text = "Delay: "
    }
}

