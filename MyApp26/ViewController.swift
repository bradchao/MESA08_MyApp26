//
//  ViewController.swift
//  MyApp26
//
//  Created by user22 on 2017/10/3.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit
import CoreLocation // GPS
import CoreMotion   // 三軸/陀螺儀

class ViewController: UIViewController, CLLocationManagerDelegate {

    let lmgr = CLLocationManager()
    let cmgr = CMMotionManager()
    
    @IBOutlet weak var labelX: UILabel!
    
    @IBOutlet weak var labelY: UILabel!
    
    @IBOutlet weak var labelZ: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 方向角度
        lmgr.delegate = self
        //lmgr.startUpdatingHeading()
        
        // 三軸加速感應器
//        cmgr.startAccelerometerUpdates(to: OperationQueue()) {
//            (data, error) in
//            let a = data?.acceleration
//            DispatchQueue.main.async {
//                self.labelX.text = "\(a!.x)"
//                self.labelY.text = "\(a!.y)"
//                self.labelZ.text = "\(a!.z)"
//            }
//        }
        
        // 陀螺儀
//        cmgr.startGyroUpdates(to: OperationQueue()) { (data, errir) in
//            let a = data?.rotationRate
//            DispatchQueue.main.async {
//                self.labelX.text = "\(a!.x)"
//                self.labelY.text = "\(a!.y)"
//                self.labelZ.text = "\(a!.z)"
//            }
//
//        }
        
        cmgr.startMagnetometerUpdates(to: OperationQueue()) { (data, error) in
                let a = data?.magneticField
                DispatchQueue.main.async {
                    self.labelX.text = "\(a!.x)"
                    self.labelY.text = "\(a!.y)"
                    self.labelZ.text = "\(a!.z)"
                }

        }
        
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        
        if device.isProximityMonitoringEnabled {
            let nc = NotificationCenter.default
            nc.addObserver(self, selector: #selector(ncfunc(_:)), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
            print("has device")
        }else{
            // 沒有此裝置
            print("no device")
        }
        
        
        
    }

    @objc func ncfunc(_ sender : NSNotification){
        let device = UIDevice.current
        if device.proximityState {
            // 靠近了
            print("OK")
        }else{
            print("XX")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading){
        if newHeading.headingAccuracy < 0 {
            // 不準了
            print("不準了:\(newHeading.headingAccuracy)")
        }else{
            print("\(newHeading.magneticHeading)")
        }
    }
}

