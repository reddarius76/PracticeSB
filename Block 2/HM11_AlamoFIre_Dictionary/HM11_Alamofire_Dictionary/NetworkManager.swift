//
//  NetworkManager.swift
//  HM11_AlamoFire_Dictionary
//
//  Created by Oleg Krikun on 22.01.2021.
//

import Alamofire

class NetworkManagerDictionary {
    
    static let shared = NetworkManagerDictionary()
    
    private init() {}
    
    private var sourceLang = "en"
    private var targetLang = "ru"
    private var lang: String {
        "\(sourceLang)-\(targetLang)"
    }
    
    func fetchWord(forWord word: String, completion: @escaping ([Def]) -> Void) {
        let apiKey = APIConfig.shared.apiKey
        let url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=\(apiKey)&lang=\(lang)&text=\(word)"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: Dictionary.self) { dataResponse in
                switch dataResponse.result {
                case .success(let wordsFromDictionary):
                    guard let words = wordsFromDictionary.def else { return }
                    var trasnletedWords = [Def]()
                    for word in words {
                        trasnletedWords.append(word)
                    }
                    DispatchQueue.main.async {
                        completion(trasnletedWords)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
