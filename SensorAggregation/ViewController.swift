//
//  ViewController.swift
//  SensorAggregation
//
//  Created by Matiss Mamedovs on 05/09/2020.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    // VARIABLES
    var gyroscopeData: RateData?
    var magnetometerData: RateData?
    var acceleromaterData: RateData?    
    
    let motionManager = CMMotionManager()
    // OUTLETS
    @IBOutlet weak var gyroXLabel: UILabel!
    @IBOutlet weak var gyroYLabel: UILabel!
    @IBOutlet weak var gyroZLabel: UILabel!
    
    @IBOutlet weak var magneXLabel: UILabel!
    @IBOutlet weak var magneYLabel: UILabel!
    @IBOutlet weak var magneZLabel: UILabel!
    
    @IBOutlet weak var acceleroXLabel: UILabel!
    @IBOutlet weak var acceleroYLabel: UILabel!
    @IBOutlet weak var acceleroZLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Colors.BACKGROUND_COLOR
        
        readGyroscopeData()
        readMagnetometerData()
        readAccelerometerData()
    }
    
    fileprivate func readGyroscopeData() {
        if motionManager.isGyroAvailable {
            motionManager.deviceMotionUpdateInterval = 0.2
            motionManager.startDeviceMotionUpdates()
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: OperationQueue.main) { (gyroData, error) in
                if error == nil {
                    if let rotation = gyroData?.rotationRate {
                        self.updateRateValues(rateData: &self.gyroscopeData, x: rotation.x, y: rotation.y, z: rotation.z)
                        self.updateGyroscopeLabels()
                    }
                } else {
                    print("There was problem: \(String(describing: error?.localizedDescription))")
                }

            }

        }
    }
    
    fileprivate func readMagnetometerData() {
        if motionManager.isMagnetometerAvailable {
            motionManager.magnetometerUpdateInterval = 0.2
            motionManager.startMagnetometerUpdates(to: OperationQueue.main) { (magneData, error) in
                if error == nil {
                    if let data = magneData?.magneticField {
                        self.updateRateValues(rateData: &self.magnetometerData, x: data.x, y: data.y, z: data.z)
                        self.updateMagnetometerLabels()
                    }
                } else {
                    print("There was problem: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    }
    
    fileprivate func readAccelerometerData() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (acceloData, error) in
                if error == nil {
                    if let data = acceloData?.acceleration {
                        self.updateRateValues(rateData: &self.acceleromaterData, x: data.x, y: data.y, z: data.z)
                        self.updateAccelerometerLabels()
                    }
                } else {
                    print("There was problem: \(String(describing: error?.localizedDescription))")
                }
            })
        }
    }
    
    fileprivate func updateRateValues(rateData: inout RateData?, x: Double, y: Double, z: Double) {
        if rateData == nil {
            rateData = RateData(x: x, y: y, z: z)
        } else {
            rateData?.updateValues(x: x, y: y, z: z)
        }
    }
    
    fileprivate func updateGyroscopeLabels() {
        self.gyroXLabel.text = gyroscopeData?.x.string
        self.gyroYLabel.text = gyroscopeData?.y.string
        self.gyroZLabel.text = gyroscopeData?.z.string
    }
    
    fileprivate func updateMagnetometerLabels() {
        self.magneXLabel.text = magnetometerData?.x.string
        self.magneYLabel.text = magnetometerData?.y.string
        self.magneZLabel.text = magnetometerData?.z.string
    }

    fileprivate func updateAccelerometerLabels() {
        self.acceleroXLabel.text = acceleromaterData?.x.string
        self.acceleroYLabel.text = acceleromaterData?.y.string
        self.acceleroZLabel.text = acceleromaterData?.z.string
    }
}

