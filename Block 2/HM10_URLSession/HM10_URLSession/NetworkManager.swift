//
//  NetworkManager.swift
//  HM10_URLSession
//
//  Created by Oleg Krikun on 21.01.2021.
//

import Foundation

class NetworkManagerWeather {
    
    static let shared = NetworkManagerWeather()
    
    private init() {}
    
    func fetchWeather(forCity city: String, completion: @escaping (WeatherInfo) -> Void)  {
        
        let apiKey = APIConfig.shared.apiKey
        let urlAPI = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlAPI) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherInfoCurrent = try decoder.decode(WeatherInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherInfoCurrent)
                }
            } catch let error {
                print("error JSONDecoder: \(error)")
            }
        }.resume()
    }
    
}
