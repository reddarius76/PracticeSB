//
//  CharacterImageView.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 25.01.2021.
//

import UIKit

class CharacterImageView: UIImageView {

    //MARK: - fetchImageCharacter()
    func fetchImageCharacter(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = UIImage(systemName: "person.circle")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            return
        }
        
        if let cachedImage = getCacheImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        NetworkManager.shared.fetchImage(from: imageURL) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    //MARK: - private func
    //MARK: - getCacheImage()
    private func getCacheImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
    
    //MARK: - saveDataToCache()
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }

}
