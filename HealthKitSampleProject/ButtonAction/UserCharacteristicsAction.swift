//
//  UserCharacteristicsAction.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-28.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import HealthKit
import UIKit

extension ViewController {

    func readCharacteristicsData() {
        do {
            guard let birthDate = try? self.healthStore.dateOfBirthComponents() else { return }
            guard let sex = try? self.healthStore.biologicalSex().biologicalSex else { return }
            guard let bloodType = try? self.healthStore.bloodType().bloodType else { return }

            DispatchQueue.main.async {
                self.lblUserAge.text = "\(birthDate.year ?? 0)"
                if sex.rawValue == 1 {
                    self.lblUserGender.text = "Fem"
                } else {
                    self.lblUserGender.text = "Male"
                }
                self.lblUserBloodType.text = self.convertBloodType(bloodType: bloodType.rawValue)
            }
        }
    }

    func convertBloodType(bloodType: Int) -> String {
        switch bloodType {
        case 1:
            return "A+"
        case 2:
            return "A-"
        case 3:
            return "B+"
        case 4:
            return "B-"
        case 5:
            return "AB+"
        case 6:
            return "AB-"
        case 7:
            return "O+"
        case 8:
            return "O+"
        default:
            return ""
        }
    }
}
