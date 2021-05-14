//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Jimmy Meriläinen on 2021-02-24.
//

import UIKit

class ViewController: UIViewController, WeatherManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherMgr = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        weatherMgr.delegate = self
        // Do any additional setup after loading the view.
    }


    @IBAction func searchButton(_ sender: UIButton) {
        weatherMgr.getWeather(city: searchField.text!)
    }
    
    func weatherDidUpdate(_weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.imageView.image = UIImage(systemName: weather.conditionName)
            
        }
    }
    // Tangentbordet försvinner
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    /*func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "Du måste skriva här!"
            return false
        }
    }*/
    
    // Gör att man kan klicka på ok i tangenten istället för searchButton
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text {
            weatherMgr.getWeather(city: city)
        }
    }
}

