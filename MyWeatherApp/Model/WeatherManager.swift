//
//  WeatherManager.swift
//  MyWeatherApp
//
//  Created by Jimmy Meriläinen on 2021-02-24.
//

import Foundation

var apiKey: String = "5ba8d014f92274c628dba3712ea5757f"

protocol WeatherManagerDelegate {
    func weatherDidUpdate(_weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?&appid=5ba8d014f92274c628dba3712ea5757f&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(city: String) {
        let urlString = "\(url)&q=\(city)"
        request(urlString: urlString)
    }
    
    func request(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if(error != nil) {
                    print(error!)
                    return
                }
                if let response = data {
                    if let weather = self.parseJson(data: response) {
                        self.delegate?.weatherDidUpdate(_weatherManager: self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let temp = decodedData.main.temp
            let city = decodedData.name
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(conditionId: id, city: city, temperature: temp)
            return weather
            
        }catch {
            print(error)
            return nil
        }
    }
}
