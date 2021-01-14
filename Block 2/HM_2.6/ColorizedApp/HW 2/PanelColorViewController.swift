//
//  PanelColorViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class PanelColorViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var colorFromMainView: UIColor!
    var delegate: PanelColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = colorFromMainView

        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setLabelText(for: redLabel, greenLabel, blueLabel)
        setTextField(for: redTextField, greenTextField, blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    // MARK: - IB Actions
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
                
        switch sender.tag {
        case 0:
            redLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case 1:
            greenLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2:
            blueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        default: break
        }
    }
    
    // Отправка цвета из colorView в главное View через делегата
    @IBAction func donePressed() {
        delegate.setColorFor(view: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    // MARK: - Private methods
    // Устанавливаем цвет colorView
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    // Устанавливаем значение для Sliders
    private func setValue(for sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider.tag {
            case 0: redSlider.value = Float(colorView.backgroundColor!.cgColor.components![0])
            case 1: greenSlider.value = Float(colorView.backgroundColor!.cgColor.components![1])
            case 2: blueSlider.value = Float(colorView.backgroundColor!.cgColor.components![2])
            default: break
            }
        }
    }
    
    private func setLabelText(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func setTextField(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField.tag {
            case 0: redTextField.text = string(from: redSlider)
            case 1: greenTextField.text = string(from: greenSlider)
            case 2: blueTextField.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    // Значения RGB
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


extension PanelColorViewController: UITextFieldDelegate {
    // Hide keyboard when tap on View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var currentText = textField.text ?? "0.00"
        if currentText.isEmpty { currentText = "0.00" }
        
        switch textField.tag {
        case 0:
            redLabel.text = currentText
            redSlider.value = Float(currentText) ?? 0.00
        case 1:
            greenLabel.text = currentText
            greenSlider.value = Float(currentText) ?? 0.00
        case 2:
            blueLabel.text = currentText
            blueSlider.value = Float(currentText) ?? 0.00
        default: break
        }
        
        setColor()
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        //Validation
        if !string.containsValidCharacterPanelColor { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 4 characters
        return updatedText.count <= 4
    }
}

extension String {

var containsValidCharacterPanelColor: Bool {
    let hexSet = CharacterSet(charactersIn: "1234567890.")
    let newSet = CharacterSet(charactersIn: self)
    return hexSet.isSuperset(of: newSet)
  }
}
