//
//  NetworkManager.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 25.01.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    //MARK: - fetchInfoCharacter
    func fetchInfoCharacter(from url: String, with comletion: @escaping (CharacterInfo) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharacterInfo.self, from: data)
                DispatchQueue.main.async {
                    comletion(result)
                }
            } catch let error {
                print("JSONDecoder error: \(error)")
            }
        }.resume()
    }
    
    //MARK: - fetchInfoCharacter
    func fetchCharacter(from url: String, with comletion: @escaping (Character) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    comletion(result)
                }
            } catch let error {
                print("JSONDecoder error: \(error)")
            }
        }.resume()
    }
    
    private init() {}
}
