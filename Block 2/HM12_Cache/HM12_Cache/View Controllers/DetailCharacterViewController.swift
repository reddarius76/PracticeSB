//
//  DetailCharacterViewController.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 25.01.2021.
//

import UIKit

class DetailCharacterViewController: UIViewController {

    @IBOutlet weak var characterImageView: CharacterImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
        }
    }
    @IBOutlet weak var descriptionCharacterLabel: UILabel!
    
    var characterID: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterImageView.fetchImageCharacter(from: characterID?.image ?? "")
        title = characterID?.name
        descriptionCharacterLabel.text = characterID?.description
    }
}
