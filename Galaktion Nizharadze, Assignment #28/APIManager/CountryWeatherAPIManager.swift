//
//  CountryWeatherAPIManager.swift
//  Galaktion Nizharadze, Assignment #28
//
//  Created by Gaga Nizharadze on 30.08.22.
//

import Foundation



protocol WeatherService {
    func fetchWeather(countryName: String, completion: @escaping (Result<WeatherOfCountry,Error>) -> ())
}

class FetchCountryWeather: WeatherService {
    
    static let shared = FetchCountryWeather()
    private init() {}
    
    private let urlSession = URLSession.shared
    private let apiKey = "d5c2719b70bede754fd091abd81c81b0"
    
    
    func fetchWeather(countryName: String, completion: @escaping (Result<WeatherOfCountry, Error>) -> ()) {
        
        let baseAPIURL = "https://api.openweathermap.org/data/2.5/weather?q=\(countryName)&appid=\(apiKey)"
        
        guard let url = URL(string: baseAPIURL) else {
            print("url is not valid")
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { data, httpResponse, error in
            if let httpResponse = httpResponse as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {   // მხოლოდ იმ შემთხვევაში ვაგრძელებთ თუ სტატუს კოდი 200 არის, რადგან 404-ის შემთხვევაში მიწოდებული ქალაქი არ არსებობს
                    return
                }
                print(httpResponse)
            }
            
            if let error = error  {
                print("api fetch error -> ", error)
            }
            
            guard let data = data else {
                print("api data is nil")
                return
            }
            
            do {
            let jsonData = try JSONDecoder().decode(WeatherOfCountry.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
