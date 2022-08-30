//
//  CountryWeather.swift
//  Galaktion Nizharadze, Assignment #28
//
//  Created by Gaga Nizharadze on 30.08.22.
//

import Foundation
import CoreVideo

// MARK: - WeatherOfCountry
struct WeatherOfCountry: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}


// MARK: - Coord
struct Coord: Decodable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike: Double
    let pressure, humidity: Int
    
    var tempInCelsius: String {
        temp.convertToCelsius()
    }
    
    var feelsLikeInCelsius: String {
        feelsLike.convertToCelsius()
    }

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let country: String
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}


extension Double {
    func convertToCelsius() -> String{
        "\(Int(self - 273.15))°C"
    }
}


enum WeatherIndicatorImage: String {
    case clouds
    case rain
    
    var value: String {
        switch self {
            
        case .clouds:
            return "cloud.fog.fill"
        case .rain:
            return "cloud.drizzle"
        }
    }
}
