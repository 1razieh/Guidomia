//
//  CommonUI.swift
//  Guidomia
//
//  Created by Razieh Halimi on 2022-09-04.
//

import Foundation
import UIKit
enum DeviceSize {
    case small
    case medium
    case big
}

func getdeviceSize()-> DeviceSize {
    if UIScreen.main.bounds.width < 375 {
        return .small
    } else if UIScreen.main.bounds.width <= 400 {
        return .medium
    } else {
        return .big
    }
}
