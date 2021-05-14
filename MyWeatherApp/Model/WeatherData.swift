//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Jimmy Meriläinen on 2021-02-24.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
    
}
