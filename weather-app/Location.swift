//
//  Location.swift
//  weather-app
//
//  Created by Bill Bithell on 6/22/16.
//  Copyright © 2016 Bill Bithell. All rights reserved.
//

import Foundation
import Alamofire

class Location {
    
    // Set private variables
    private var _day: String!
    private var _date: String!
    private var _time: String!
    
    private var _id: String!
    
    private var _humidity: String!
    
    private var _locationName: String!
    
    private var _rainAmount: String!
    
    private var _temp: String!
    private var _tempLow: String!
    private var _tempHigh: String!
    
    private var _weatherCondition: String!
    private var _weatherConditionDesc: String!
    private var _weatherIconId: String!
    private var _weatherId: String!
    
    private var _windDirection: WindDirection!
    private var _windSpeed: String!
    
    private var _zipCode: String!
    
    private var _weatherUrl: String!
    
    enum WindDirection {
        case N
        case NNE
        case NE
        case ENE
        case E
        case ESE
        case SE
        case SSE
        case S
        case SSW
        case SW
        case WSW
        case W
        case WNW
        case NW
        case NNW
    }
    
    // Getters
    var day: String {
        if _day == nil {
            _day = ""
        }
        return _day
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var time: String {
        if _time == nil {
            _time = ""
        }
        return _time
    }
    
    var id: String {
        if _id == nil {
            _id = ""
        }
        return _id
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var locationName: String {
        if _locationName == nil {
            _locationName = ""
        }
        return _locationName
    }
    
    var temp: String {
        if _temp == nil {
            _temp = ""
        }
        return _temp
    }
    
    var tempLow: String {
        if _tempLow == nil {
            _tempLow = ""
        }
        return _tempLow
    }
    
    var tempHigh: String {
        if _tempHigh == nil {
            _tempHigh = ""
        }
        return _tempHigh
    }
    
    var weatherCondition: String {
        if _weatherCondition == nil {
            _weatherCondition = ""
        }
        return _weatherCondition
    }
    
    var weatherConditionDesc: String {
        if _weatherConditionDesc == nil {
            _weatherConditionDesc = ""
        }
        return _weatherConditionDesc
    }
    
    var weatherIconId: String {
        if _weatherIconId == nil {
            _weatherIconId = ""
        }
        return _weatherIconId
    }
    
    var weatherId: String {
        if _weatherId == nil {
            _weatherId = ""
        }
        return _weatherId
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        return _windSpeed
    }
    
    var windDirection: WindDirection {
        get {
            return _windDirection
        }
    }
    
    init(location: String, zipCode: String) {
        self._locationName = "Bridgewater, MA"
        self._zipCode = URL_ZIP
        
        self._weatherUrl = "\(URL_BASE)\(self._zipCode)\(URL_UNITS)\(API_KEY)"
    }
    
    func downloadCurrentWeatherDetails(completed: DownloadComplete) {
        let url = "\(URL_BASE)\(self._zipCode)\(URL_UNITS)\(API_KEY)"
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result

            if let resultDictonary = result.value as? Dictionary<String, AnyObject> {
                
                if let dt = resultDictonary["dt"] as? Double {
                    let date = NSDate(timeIntervalSince1970: dt)
                    let dayFormatter = NSDateFormatter()
                    let dateFormatter = NSDateFormatter()
                    let timeFormatter = NSDateFormatter()
                    dayFormatter.dateFormat = "EEEE"
                    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
                    timeFormatter.dateFormat = "h:mm a"
                    self._day = dayFormatter.stringFromDate(date)
                    self._date = dateFormatter.stringFromDate(date)
                    self._time = timeFormatter.stringFromDate(date)
                }
                
                // id
                if let resId = resultDictonary["id"] as? Int {
                    self._id = "\(resId)"
                }
                
                // name
                //if let resName = resultDictonary["name"] as? String {
                //    self._locationName = resName
                //}
                
                // temps
                if let temps = resultDictonary["main"] as? Dictionary<String, AnyObject> {
                    
                    if let resTemp = temps["temp"] as? Int {
                        self._temp = "\(resTemp)°"
                    }
                    
                    if let resTempLow = temps["temp_min"] as? Int {
                        self._tempLow = "\(resTempLow)°"
                    }
                    
                    if let resTempHigh = temps["temp_max"] as? Int {
                        self._tempHigh = "\(resTempHigh)°"
                    }
                    
                    // humidity
                    if let resHumidity = temps["humidity"] as? Int {
                        self._humidity = "\(resHumidity)"
                    }
                }
                
                // conditions
                if let weather = resultDictonary["weather"] as? [Dictionary<String, AnyObject>] {
                    if let resWeatherCondition = weather[0]["main"] as? String {
                        self._weatherCondition = resWeatherCondition
                    }
                    
                    if let resWeatherConditionDesc = weather[0]["description"] as? String {
                        self._weatherConditionDesc = resWeatherConditionDesc
                    }
                    
                    if let resWeatherIconId = weather[0]["icon"] as? String {
                        self._weatherIconId = resWeatherIconId
                    }
                    
                    if let resWeatherId = weather[0]["id"] as? Int {
                        self._weatherId = "\(resWeatherId)"
                    }
                }
                
                // wind
                if let windDetl = resultDictonary["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = windDetl["speed"] as? Double {
                        self._windSpeed = NSString(format: "%.0f", speed) as String
                        
                    }
                    
                    if let direc = windDetl["deg"] as? Double {
                        switch (direc) {
                        case 348.75...360:
                            self._windDirection = WindDirection.N
                        case 0..<11.25:
                            self._windDirection = WindDirection.N
                        case 11.25..<33.75:
                            self._windDirection = WindDirection.NNE
                        case 33.75..<56.25:
                            self._windDirection = WindDirection.NE
                        case 56.25..<78.75:
                            self._windDirection = WindDirection.ENE
                        case 78.75..<101.25:
                            self._windDirection = WindDirection.E
                        case 101.25..<123.75:
                            self._windDirection = WindDirection.ESE
                        case 123.75..<146.25:
                            self._windDirection = WindDirection.SE
                        case 146.25..<168.75:
                            self._windDirection = WindDirection.SSE
                        case 168.75..<191.25:
                            self._windDirection = WindDirection.S
                        case 191.25..<213.75:
                            self._windDirection = WindDirection.SSW
                        case 213.75..<236.25:
                            self._windDirection = WindDirection.SW
                        case 236.25..<258.75:
                            self._windDirection = WindDirection.WSW
                        case 258.75..<281.25:
                            self._windDirection = WindDirection.W
                        case 281.25..<303.75:
                            self._windDirection = WindDirection.WNW
                        case 303.75..<326.25:
                            self._windDirection = WindDirection.NW
                        case 326.25..<348.75:
                            self._windDirection = WindDirection.NNW
                        default:
                            self._windDirection = WindDirection.N
                        }
                    }
                }
            }
            completed()
        }
    }
}
