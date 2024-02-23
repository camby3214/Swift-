//
//  model.swift
//  API
//
//  Created by 李韋辰 on 2022/3/17.
//
import UIKit
import Foundation

struct CurrentWeatherData: Decodable {
    var name: String
    var id: Int
    var coord: Coord
    var main: Main
    var weather: [Weather]
}

struct Coord: Decodable {
    var lon: Double
    var lat: Double
}

struct Main: Decodable {
    var temp: Double
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Decodable {
    var icon: String
    var main: String
    var description: String
}

struct APIKeys{
    static let apikey = "2c69c2ee08c710dd0f273075a1b77ae9"
}
