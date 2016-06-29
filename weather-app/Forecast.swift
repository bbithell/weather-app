//
//  Forecast.swift
//  weather-app
//
//  Created by Bill Bithell on 6/23/16.
//  Copyright © 2016 Bill Bithell. All rights reserved.
//

import Foundation
import Alamofire

class Forecast {
    
    private var _weatherFc = [Forecast] ()
    private var _day: String!
    private var _tempAvg: String!
    private var _tempHigh: String!
    private var _tempLow: String!
    private var _conditionIcon: String!
    
    var day: String {
        if _day == nil {
            _day = ""
        }
        return _day
    }
    
    var tempAvg: String {
        if _tempAvg == nil {
            _tempAvg = ""
        }
        return _tempAvg
    }
    
    var tempHigh: String {
        if _tempHigh == nil {
            _tempHigh = ""
        }
        return _tempHigh
    }
    
    var tempLow: String {
        if _tempLow == nil {
            _tempLow = ""
        }
        return _tempLow
    }
    
    var conditionIcon: String {
        if _conditionIcon == nil {
            _conditionIcon = ""
        }
        return _conditionIcon
    }
    
    var weatherFc: [Forecast] {
        return self._weatherFc
    }
    
    init () {
        
    }
    
    init(day: String, tempAvg: String, tempHigh: String, tempLow: String, icon: String) {
        _day = day
        _tempAvg = tempAvg
        _tempHigh = tempHigh
        _tempLow = tempLow
        _conditionIcon = icon
    }
    
    func downloadForecast(completed: DownloadComplete) {
        //let zipCode = "02324"
        let url = "\(URL_FORECAST_BASE)\(URL_LOCATION_ID)\(URL_FORECAST_UNITS)\(API_KEY)"
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let fResultDict = result.value as? Dictionary<String, AnyObject> {
                if let list = fResultDict["list"] as? [Dictionary<String, AnyObject>] where list.count > 0 {
                    
                    for x in 0..<list.count {
                    //repeat {
                        
                        //let weatherFc = Forecast()
                        
                        if let dt = list[x]["dt"] as? Double {
                            let date = NSDate(timeIntervalSince1970: dt)
                            let dayFormatter = NSDateFormatter()
                            dayFormatter.dateFormat = "EEEE"
                            self._day = dayFormatter.stringFromDate(date)
                        }
                        
                        if let temps = list[x]["temp"] as? Dictionary<String, AnyObject> {
                            
                            if let resTempAvg = temps["day"] as? Int {
                                self._tempAvg = "\(resTempAvg)°"
                            }
                            
                            if let resTempLow = temps["min"] as? Int {
                                self._tempLow = "\(resTempLow)°"
                            }
                            
                            if let resTempHigh = temps["max"] as? Int {
                                self._tempHigh = "\(resTempHigh)°"
                            }
                        }
                        
                        if let weather = list[x]["weather"] as? [Dictionary<String, AnyObject>] {
                            
                            if let resWeatherIconId = weather[0]["icon"] as? String {
                                self._conditionIcon = resWeatherIconId
                            }
                        }
                        
                        let day = Forecast(day: self.day, tempAvg: self.tempAvg, tempHigh: self.tempHigh, tempLow: self.tempLow, icon: self.conditionIcon)
                        self._weatherFc.append(day)
                    }
                }
            }
            
            completed()
        }
    }
}















