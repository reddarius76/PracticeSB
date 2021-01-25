//
//  CharacterImageView.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 25.01.2021.
//

import UIKit

class CharacterImageView: UIImageView {

    func fetchImageCharacter(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = #imageLiteral(resourceName: "picture")
            return
        }
        
        NetworkManager.shared.fetchImage(from: imageURL) { data, _ in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }

}
