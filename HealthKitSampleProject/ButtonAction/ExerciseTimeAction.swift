//
//  ExerciseTimeAction.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-29.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import UIKit
import HealthKit

extension ViewController {

    func readExerciseTime() {
        guard let exerciseType = HKSampleType.quantityType(forIdentifier: .appleExerciseTime) else {
            print("Sample type not available")
            return
        }
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let exerciseTimeQuery = HKSampleQuery(sampleType: exerciseType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, sample, error) in
            if error != nil {
                print("Something went wrong with your exercise time: \(error)")
                return
            }
            guard let quantitySample = sample as? [HKQuantitySample] else {
                print("Something went wrong: \(error)")
                return
            }
            let firstSample = quantitySample[0...10]
            print("First Sample: \(firstSample)")
            let total = quantitySample.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.minute()) }
            DispatchQueue.main.async {
                self.lblExerciseTime.text = "\(total)"
            }
        }
        HKHealthStore().execute(exerciseTimeQuery)
    }
}
