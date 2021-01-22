//
//  ViewController.swift
//  HM10_URLSession
//
//  Created by Oleg Krikun on 21.01.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var tempCityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPressed()
        
    }
    
    @IBAction func searchPressed() {
        NetworkManagerWeather.shared.fetchWeather(forCity: cityTextField.text ?? "Moscow") { [self] weatherInfoCurrent in
            tempCityLabel.text =
                "Temperature in "
                + String(weatherInfoCurrent.name ?? "Moscow")
                + " is "
                + String(weatherInfoCurrent.main?.temp ?? 0)
                + "°C"
        }
    }
}

