//
//  MainViewViewModel.swift
//  Galaktion Nizharadze, Assignment #28
//
//  Created by Gaga Nizharadze on 30.08.22.
//

import Foundation

class MainViewViewModel {
    
    var reloadTableView: (()->Void)?
    
    private var weatherModel: WeatherOfCountry? {
        didSet {
            self.reloadTableView?()
        }
    }
  
    
    func fetchWeather(countryName: String) {
        FetchCountryWeather.shared.fetchWeather(countryName: countryName) { [weak self] response in
            switch response {
            case.success(let weather):
                self?.weatherModel = weather
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        weatherModel != nil ? 1 : 0
    }
    
    func cellForRowAt() -> String? {
        weatherModel?.name
    }
    
    func didSelectRowAt() -> WeatherOfCountry? {
        return weatherModel
    }
    
    
    
    
    
}
