//
//  HealthAuthorizationButton.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-27.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import Foundation
import HealthKit
import UIKit

extension ViewController {

    typealias AuthorizationCompletion = (Result<Bool, HKError>) -> Void

    func requestHealthKitPermission( completion: @escaping AuthorizationCompletion) {

        guard let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
              let activeEnergyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
              let sex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
              let age = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
              let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType)
            else {
                return
            }


        let sampleType: Set<HKObjectType> = [heartRate,
                                            activeEnergyBurned,
                                            sleepAnalysis,
                                            sex,
                                            age,
                                            bloodType]

        self.requestAuthorization(toShare: sampleType, read: sampleType, completion: completion)
    }

    func requestAuthorization(toShare share: Set<HKObjectType>?, read: Set<HKObjectType>?, completion: @escaping AuthorizationCompletion) {
        healthStore.requestAuthorization(toShare: share as? Set<HKSampleType>, read: read) { (success, error) in
            if let error = error {
                completion(.failure(error as! HKError))
            } else {
                DispatchQueue.main.async {
                    self.didRequestAutorization = true
                    self.lblHealthKitStatus.textColor = .systemGreen
                    self.lblHealthKitStatus.text = "Connected"
                    completion(.success(success))
                }
            }
        }
    }

    func saveHeartRate(date: Date = Date(), heartRate heartRateValue: Double, completion completionBlock: @escaping (Bool, Error?) -> Void) {
        let unit = HKUnit.count().unitDivided(by: HKUnit.minute())
        let quantity = HKQuantity(unit: unit, doubleValue: heartRateValue)
        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        let heartRateSample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)

        self.healthStore.save(heartRateSample) { (success, error) -> Void in
            if !success {
                print("An error occured saving the HR sample \(heartRateSample). In your app, try to handle this gracefully. The error was: \(error).")
            }
            completionBlock(success, error)
        }
    }
}
