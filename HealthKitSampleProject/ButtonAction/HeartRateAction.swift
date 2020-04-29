//
//  HeartRateAction.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-27.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import Foundation
import HealthKit

extension ViewController {

    func readHeartRate() {
        guard let heartRateType = HKSampleType.quantityType(forIdentifier: .heartRate) else {
            print("Sample type not available")
            return
        }

        let week = Calendar.current.dateComponents([.weekday], from: Date())
        let weekAgo = Calendar.current.date(from: week)
        let lastWeek = HKQuery.predicateForSamples(withStart: weekAgo, end: Date(), options: .strictEndDate)

        let heartRateQuery = HKSampleQuery(sampleType: heartRateType, predicate: lastWeek, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, sample, error) in
            guard error == nil,
                let quantitySamples = sample as? [HKQuantitySample] else {
                    print("Something went wrong heart rate: \(error)")
                    return
            }
            let firstSample = quantitySamples[0]
//            print("First Sample: \(firstSample)")
            let total = quantitySamples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.init(from: "count/min")) }
//            print("Heart Rate: \(total)")
            DispatchQueue.main.async {
                self.lblHeartRate.text = String(format: "%.2f", total)
            }
        }
        HKHealthStore().execute(heartRateQuery)
    }
    
}
