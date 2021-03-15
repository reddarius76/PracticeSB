//
//  NetworkManager.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 25.01.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchCharacter(url: String, page: Int, name: String? = nil, dataTasks: [URLSessionDataTask?], with comletion: @escaping (CharacterInfo?) -> Void) -> URLSessionDataTask? {
        
        var apiURLOptional: String?
        if let name = name {
            apiURLOptional = url + "?page=\(page)" + "&name=\(name)"
        } else {
            apiURLOptional = url + "?page=\(page)"
        }
        
        guard let apiURL = apiURLOptional else { return nil }
        guard let url = URL(string: apiURL) else { return nil }
        
        if dataTasks.firstIndex(where: { task in
            task?.originalRequest?.url == url
          }) != nil {
            return nil
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description")
                comletion(nil)
                return
            }
            
            guard url == response?.url else { return }
            
            do {
                let result = try JSONDecoder().decode(CharacterInfo.self, from: data)
                DispatchQueue.main.async {
                    comletion(result)
                }
            } catch let error {
                print("fetchInfoCharacter JSONDecoder error: \(error)")
            }
        }
        dataTask.resume()
        
        return dataTask
    }
    
    //MARK: - fetchImage()
    func fetchImage(from url: URL, with comletion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? " ")
                return
            }
            guard url == response.url else { return }
            comletion(data, response)
        }.resume()
    }
    
    //MARK: - Private init()
    private init() {}
}
