//
//  SleepTimeAction.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-29.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import Foundation
import HealthKit

extension ViewController {

    func readSleepTime() {
        guard let sleepTime = HKSampleType.categoryType(forIdentifier: .sleepAnalysis) else {
            print("Sample type not available")
            return
        }
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//        let week = Calendar.current.dateComponents([.weekday], from: Date())
//        let weekAgo = Calendar.current.date(from: week)
//        let lastWeek = HKQuery.predicateForSamples(withStart: weekAgo, end: Date(), options: .strictEndDate)

        let sleepTimeQuery = HKSampleQuery(sampleType: sleepTime, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error) in
            if error != nil {
                print("Something went wrong with your sleep time: \(error)")
                return
            }

            if let result = results {
                for item in result {
                    if let sample = item as? HKCategorySample {
                        let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                        DispatchQueue.main.async {
                            print("Healthkit sleep: \(sample.startDate) \(sample.endDate) - value: \(value)")
                            self.lblStartSleepTime.text = "\(sample.startDate)"
                            self.lblEndSleepTime.text = "\(sample.endDate)"

                        }
                    }
                }
            }

//            let quantitySamples = results as? [HKQuantitySample]
//
//            let firstSample = quantitySamples![0]
//            print("First Sample: \(firstSample)")
//            let total = quantitySamples!.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.minute()) }
//            DispatchQueue.main.async {
//                self.lblStartSleepTime.text = String(format: "%.2f", total)
//            }
        }
        HKHealthStore().execute(sleepTimeQuery)
    }
}
