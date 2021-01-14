//
//  ViewController.swift
//  HW_2.2
//
//  Created by Oleg Krikun on 03.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorPanelView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    private let minValueSlider: Float = 0
    private let maxValueSlider: Float = 255
    private let thumbValueSlider: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPanelView.layer.cornerRadius = 15
        
        redSlider.minimumValue = minValueSlider
        redSlider.maximumValue = maxValueSlider
        redSlider.value = thumbValueSlider
        
        greenSlider.minimumValue = minValueSlider
        greenSlider.maximumValue = maxValueSlider
        greenSlider.value = thumbValueSlider
        
        blueSlider.minimumValue = minValueSlider
        blueSlider.maximumValue = maxValueSlider
        blueSlider.value = thumbValueSlider
        
        redLabel.text = String(Int(greenSlider.value))
        greenLabel.text = String(Int(greenSlider.value))
        blueLabel.text = String(Int(blueSlider.value))
        
        colorPanelView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255.0,
            green: CGFloat(greenSlider.value) / 255.0,
            blue: CGFloat(blueSlider.value) / 255.0,
            alpha: 1)
    }
    
    @IBAction func redSliderAction() {
        redLabel.text = String(Int(redSlider.value))
        colorPanelView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255.0,
            green: CGFloat(greenSlider.value) / 255.0,
            blue: CGFloat(blueSlider.value) / 255.0,
            alpha: 1)
    }
    
    @IBAction func greenSliderAction() {
        greenLabel.text = String(Int(greenSlider.value))
        colorPanelView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255.0,
            green: CGFloat(greenSlider.value) / 255.0,
            blue: CGFloat(blueSlider.value) / 255.0,
            alpha: 1)
    }
    
    @IBAction func blueSliderAction() {
        blueLabel.text = String(Int(blueSlider.value))
        colorPanelView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255.0,
            green: CGFloat(greenSlider.value) / 255.0,
            blue: CGFloat(blueSlider.value) / 255.0,
            alpha: 1)
    }
    
}

