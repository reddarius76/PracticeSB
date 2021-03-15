//
//  ViewController.swift
//  HM11_AlamoFire_Dictionary
//
//  Created by Oleg Krikun on 22.01.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var originWordTextField: UITextField!
    @IBOutlet var targetWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManagerDictionary.shared.fetchWord(forWord: "racoon") { [self] transletedWords in
            targetWordLabel.text = transletedWords.first?.tr?.first?.text?.capitalized
        }
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        NetworkManagerDictionary.shared.fetchWord(forWord: originWordTextField.text?.lowercased() ?? "racoon") { [self] transletedWords in
            targetWordLabel.text = transletedWords.first?.tr?.first?.text?.capitalized
        }
    }
    
}

