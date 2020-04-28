//
//  HealthKitManager.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-28.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import UIKit
import HealthKit

extension ViewController {

    func readEnergyBurned() {
        guard let energyType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Sample type not available")
            return
        }
        let week = Calendar.current.dateComponents([.weekday], from: Date())
        let weekAgo = Calendar.current.date(from: week)
        let lastWeek = HKQuery.predicateForSamples(withStart: weekAgo, end: Date(), options: .strictEndDate)

        let energyQuery = HKSampleQuery(sampleType: energyType, predicate: lastWeek, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, sample, error) in

            guard error == nil,
                  let quantitySamples = sample as? [HKQuantitySample] else {
                print("Something went wrong: \(error)")
                return
            }
            let firstSample = quantitySamples[0...10]
            print("First Sample: \(firstSample)")
            let total = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.kilocalorie()) }
                                            print("Total kcal: \(total)")
            DispatchQueue.main.async {
                                                self.lblEnergyBurned.text = String(format: "%.2f", total, "Kcal")
                                            }
        }
        HKHealthStore().execute(energyQuery)
    }
    
}
