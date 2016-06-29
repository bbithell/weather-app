//
//  Constants.swift
//  weather-app
//
//  Created by Bill Bithell on 6/22/16.
//  Copyright © 2016 Bill Bithell. All rights reserved.
//

import Foundation

public let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?zip="
public let URL_FORECAST_BASE = "http://api.openweathermap.org/data/2.5/forecast/daily?id="
public let URL_LOCATION_ID = "4931303"
public let URL_ZIP = "02324"
public let URL_UNITS = ",us&units=imperial&appid="
public let URL_FORECAST_UNITS = "&cnt=6&units=imperial&appid="
public let API_KEY = ""


typealias DownloadComplete = () -> ()