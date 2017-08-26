//
//  HoustonTempViewController.swift
//  WeatherInHouston
//
//  Created by Hannah Lin on 2017-08-24.
//  Copyright © 2017 Hannah Lin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HoustonTempViewController: UIViewController {
    
    @IBOutlet weak var temperatureDisplayField: UITextField!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiToContact = "http://api.openweathermap.org/data/2.5/weather?q=Houston&APPID=73c185f18ad3f1415c96f34fafadddf6"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // value in JSON file is in Kelvin
                    let tempInHoustonInKelvin = json["main"]["temp"].doubleValue
                    
                    // to convert Kelvin to Celsius, subtract 273.15
                    let tempInHoustonInCelsius = tempInHoustonInKelvin - 273.15
                    
                    // change text to display temperature in Houston
                    self.temperatureDisplayField.text = "\(tempInHoustonInCelsius) \u{00B0}C"
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func refreshTemperatureDisplay(_ sender: UIButton) {
        self.viewDidLoad()
    }


}
