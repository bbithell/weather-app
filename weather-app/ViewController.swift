//
//  ViewController.swift
//  weather-app
//
//  Created by Bill Bithell on 6/22/16.
//  Copyright © 2016 Bill Bithell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var conditionDesc: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempLow: UILabel!
    @IBOutlet weak var tempHigh: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    
    @IBOutlet weak var dayOneName: UILabel!
    @IBOutlet weak var dayOneImage: UIImageView!
    @IBOutlet weak var dayOneTemp: UILabel!
    
    @IBOutlet weak var dayTwoName: UILabel!
    @IBOutlet weak var dayTwoImage: UIImageView!
    @IBOutlet weak var dayTwoTemp: UILabel!
    
    @IBOutlet weak var dayThreeName: UILabel!
    @IBOutlet weak var dayThreeImag: UIImageView!
    @IBOutlet weak var dayThreeTemp: UILabel!
    
    @IBOutlet weak var dayFourName: UILabel!
    @IBOutlet weak var dayFourImage: UIImageView!
    @IBOutlet weak var dayFourTemp: UILabel!
    
    @IBOutlet weak var dayFiveName: UILabel!
    @IBOutlet weak var dayFiveImage: UIImageView!
    @IBOutlet weak var dayFiveTemp: UILabel!
    
    
    var location: Location!
    var forecast = Forecast()
    
    //var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //headerView.layer.shadowColor = UIColor.blackColor().CGColor
        //headerView.layer.shadowOffset = CGSizeZero
        //headerView.layer.shadowRadius = 3
        //headerView.layer.shadowOpacity = 1
        
        location = Location(location: "Bridgewater, MA", zipCode: "02324")
        location.downloadCurrentWeatherDetails {
            () -> () in
                self.updateUi()
        }
        
        
        forecast.downloadForecast { 
            () -> () in
            self.updateForecastUi()
        }
        
    }
    
    func updateUi() {
        locationName.text = location.locationName
        conditionDesc.text = location.weatherConditionDesc
        temp.text = location.temp
        tempLow.text = location.tempLow
        tempHigh.text = location.tempHigh
        windSpeed.text = "\(location.windSpeed) mph"
        windDirection.text = "\(location.windDirection)"
        currentTime.text = "\(location.time) \(location.day)"
        
        if let condImg = UIImage(named: location.weatherIconId){
            weatherIcon.image = condImg
        }
    }
    
    func updateForecastUi() {
        
        var weatherFc = forecast.weatherFc[1]
        
        dayOneName.text = weatherFc.day
        
        dayOneTemp.text = weatherFc.tempAvg
        
        if let d1Img = UIImage(named: weatherFc.conditionIcon) {
            dayOneImage.image = d1Img
        }
        
        weatherFc = forecast.weatherFc[2]
        
        dayTwoName.text = weatherFc.day
        
        dayTwoTemp.text = weatherFc.tempAvg
        
        if let d2Img = UIImage(named: weatherFc.conditionIcon) {
            dayTwoImage.image = d2Img
        }
        
        weatherFc = forecast.weatherFc[3]
        
        dayThreeName.text = weatherFc.day
        
        dayThreeTemp.text = weatherFc.tempAvg
        
        if let d3Img = UIImage(named: weatherFc.conditionIcon) {
            dayThreeImag.image = d3Img
        }
        
        weatherFc = forecast.weatherFc[4]
        
        dayFourName.text = weatherFc.day
        
        dayFourTemp.text = weatherFc.tempAvg
        
        if let d4Img = UIImage(named: weatherFc.conditionIcon) {
            dayFourImage.image = d4Img
        }
        
        weatherFc = forecast.weatherFc[5]
        
        dayFiveName.text = weatherFc.day
        
        dayFiveTemp.text = weatherFc.tempAvg
        
        if let d5Img = UIImage(named: weatherFc.conditionIcon) {
            dayFiveImage.image = d5Img
        }
        
    }
}

