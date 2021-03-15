//
//  CharacterCell.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 25.01.2021.
//

import UIKit

class CharacterCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var characterNameLable: UILabel!
    @IBOutlet weak var characterImage: CharacterImageView! {
        didSet {
            characterImage.contentMode = .scaleAspectFit
            characterImage.layer.cornerRadius = characterImage.frame.size.width / 2
        }
    }
    
    //MARK: - configureCell()
    func configureCell(with result: Result?) {
        characterNameLable.text = result?.name ?? ""
        characterImage.fetchImageCharacter(from: result?.image ?? "")
    }
}



