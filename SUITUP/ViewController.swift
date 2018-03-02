//
//  ViewController.swift
//  HealthHack
//
//  Created by Sai Girap on 2/13/18.
//  Copyright © 2018 Sai Girap. All rights reserved.
//

import UIKit
import HealthKit

let healthkitStore = HKHealthStore()

class ViewController: UIViewController
{
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        getHealthKitPermission()
        
        readSteps()
           
        
    }
    
    func getHealthKitPermission()
    {
        let healthkitTypesToRead = NSSet(array: [
            
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) ?? "",
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed) ?? "",
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height) ?? "",
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass) ?? "",
            ])
        
        let healthkitTypesToWrite = NSSet(array: [])
        
        healthkitStore.requestAuthorization(toShare: healthkitTypesToWrite as? Set, read: healthkitTypesToRead as? Set) { (success, error) in
            if success
            {
                print("Permission accept.")
                self.readHeight()
                self.readWeight()
                self.readSteps()
                self.saveWeight()
                self.saveHeight()
                
            }
            else
            {
                if error != nil
                {
                    print(error ?? "")
                }
                print("Permission denied.")
            }
        }
    }
    
    
    func saveHeight()
    {
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
        {
            let date = Date()
            let quantity = HKQuantity(unit: HKUnit.inch(), doubleValue: 100.0)
            let sample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
            healthkitStore.save(sample, withCompletion: { (success, error) in
                print("Saved \(success), error \(error)")
            })
        }
    }
    
    func saveWeight()
    {
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        {
            let date = Date()
            let quantity = HKQuantity(unit: HKUnit.pound(), doubleValue: 100.0)
            let sample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
            healthkitStore.save(sample, withCompletion: { (success, error) in
                print("Saved \(success), error \(error)")
            })
        }
    }

    
    func readWeight()
    {
        let bodyMass = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let query = HKSampleQuery(sampleType: bodyMass, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample
            {
                print("Weight => \(result.quantity)")
            }
            else
            {
                print("OOPS didnt get weight \nResults => \(results), error => \(error)")
            }
        }
        healthkitStore.execute(query)
    }
    
    func readHeight()
    {
        let height = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        let query = HKSampleQuery(sampleType: height, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample
            {
                print("Height => \(result.quantity)")
            }
            else
            {
                print("OOPS didnt get height \nResults => \(results), error => \(error)")
            }
        }
        healthkitStore.execute(query)
    }
    
    func readSteps()
    {
        let steps = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        let query = HKSampleQuery(sampleType: steps, predicate: nil, limit: 1, sortDescriptors: nil) { (query, results, error) in
            if let result = results?.first as? HKQuantitySample
            {
                print("Steps => \(result.quantity)")
            }
            else
            {
                print("OOPS didnt get steps \nResults => \(results), error => \(error)")
            }
        }
        healthkitStore.execute(query)
    }
    
    @IBAction func healthStats(_ sender: Any)
    {
     //   print(HKQuantityTypeIdentifier.bodyMass)
    }
    
    
  
    
}

