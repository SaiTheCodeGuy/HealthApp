//
//  ViewController.swift
//  HealthHack
//
//  Created by Sai Girap on 3/20/18.
//  Copyright © 2018 Sai Girap. All rights reserved.
//

import UIKit
import HealthKit

let healthkitStore = HKHealthStore()


class ViewController: UIViewController
{
    
    @IBOutlet var enableHealthKitButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func enableHealthKit(_ sender: Any)
    {
        getHealthKitPermission()
    }
    
    
    func getHealthKitPermission()
    {
        let healthkitTypesToRead = NSSet(array: [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) ?? "",
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height) ?? "",
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass) ?? "",
            ])
        
        
        healthkitStore.requestAuthorization(toShare: nil, read: healthkitTypesToRead as? Set) { (success, error) in
            if success
            {
                print("Permission accept.")
                self.saveWeight()
                self.saveHeight()
                self.saveSteps()
                self.readHeight()
                self.readWeight()
                self.readSteps()
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
    
    func saveSteps()
    {
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        {
            let date = Date()
            let quantity = HKQuantity(unit: HKUnit.count(), doubleValue: 100.0)
            let sample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
            healthkitStore.save(sample, withCompletion: { (success, error) in
                print("Saved \(success), error \(error)")
            })
        }
    }
    
//--------------------------------------------------------------------
    
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
        let steps = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
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
 
    
    
    
    
    
    
    
    
    
    
    
    

    
  
    
}

