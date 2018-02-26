//
//  ViewController.swift
//  HealthHack
//
//  Created by Ronak Chaudhuri on 2/13/18.
//  Copyright © 2018 Ronak Chaudhuri. All rights reserved.
//

import UIKit
import HealthKit

let healhKitStore:HKHealthStore = HKHealthStore()
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func authorizeHealthKitinApp()
    {
        let healthKitTypesToRead : Set<HKObjectType = [
        HKObjectType.HKCharacteristicType(for identifier: HKCharacteristicType)
        
        ]
        
        
    }
    
}

