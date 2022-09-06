//
//  CarViewModel.swift
//  Guidomia
//
//  Created by Razieh Halimi on 2022-08-31.
//

import Foundation

class CarListViewModel {
    
    var ListOfCar = [CarViewModel]()
    
    init() {
        populateData()
    }
    
    func populateData() {
        WebService().getData { [weak self] cars in
            self?.ListOfCar = cars.map(CarViewModel.init)
        }
    }
}

struct CarViewModel {
    
    var car: Car
    
    var consList: [String] {
        return car.consList
    }
    
    var prosList: [String] {
        return car.prosList
    }
    
    var customerPrice: Double {
        return car.customerPrice
    }
    
    var makeAndModel: String {
        return   "\(car.make) \(car.model)"
    }
    
    var model: String {
        return car.model
    }
    
    var make: String {
        return car.make
    }
    
    var rating: Int {
        return car.rating
    }
    
    var marketPrice: String {
        let price = Int(customerPrice / 1000)
        return  "\(price)\(priceSign)"
       
    }
    
}
