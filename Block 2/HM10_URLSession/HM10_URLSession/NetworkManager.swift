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
        
        let api_key = "539a1232e52fd50dd6986a8dd65074fc"
        let url_api = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(api_key)"
        
        guard let url = URL(string: url_api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let weatherInfoCurrent = try JSONDecoder().decode(WeatherInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherInfoCurrent)
                }
            } catch let error {
                print("error JSONDecoder: \(error)")
            }
        }.resume()
    }
    
}
