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
            image = UIImage(systemName: "prohibit")
            return
        }
        
        if let cachedImage = getCacheImage(from: imageURL) {
            print("cachedImage \(imageURL)")
            image = cachedImage
            return
        }
        
        print("fetchImage \(imageURL)")
        NetworkManager.shared.fetchImage(from: imageURL) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func getCacheImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }

}
