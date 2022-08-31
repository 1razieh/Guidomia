//
//  Car.swift
//  Guidomia
//
//  Created by Razieh Halimi on 2022-08-31.
//

import Foundation

struct Car: Codable {
    let consList: [String]
    let customerPrice: Double
    let make: String
    let marketPrice: Double
    let model: String
    let prosList: [String]
    var rating: Int
}
