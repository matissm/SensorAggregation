//
//  RateData.swift
//  SensorAggregation
//
//  Created by Matiss Mamedovs on 05/09/2020.
//

import Foundation
import UIKit

class RateData: NSObject {
    fileprivate(set) var x: Double!
    fileprivate(set) var y: Double!
    fileprivate(set) var z: Double!
    
    init(x: Double, y: Double, z: Double) {
        super.init()
        
        setValues(x: x, y: y, z: z)
    }
    
    func updateValues(x: Double, y: Double, z: Double) {
        setValues(x: x, y: y, z: z)
    }
    
    fileprivate func setValues(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}
