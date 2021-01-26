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
    
    var characterID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchCharacter(from: urlAPI.urlCharacter.rawValue + String(characterID!)) { character in
            self.characterImageView.fetchImageCharacter(from: character.image ?? "")
            self.navigationController?.navigationBar.topItem?.title = character.name
            self.descriptionCharacterLabel.text = character.description
        }
    }
}
