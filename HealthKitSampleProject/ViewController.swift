//
//  ViewController.swift
//  HealthKitSampleProject
//
//  Created by Ricardo Sampaio on 2020-04-27.
//  Copyright © 2020 Kinduct. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHealthKitStatus: UILabel!
    @IBOutlet weak var lblHeartRate: UILabel!
    @IBOutlet weak var lblEnergyBurned: UILabel!
    @IBOutlet weak var lblExerciseTime: UILabel!
    @IBOutlet weak var lblStartSleepTime: UILabel!
    @IBOutlet weak var lblEndSleepTime: UILabel!
    @IBOutlet weak var lblUserAge: UILabel!
    @IBOutlet weak var lblUserGender: UILabel!
    @IBOutlet weak var lblUserBloodType: UILabel!

    let healthStore = HKHealthStore()
    var heartRateQuery: HKQuery!
    var didRequestAutorization: Bool!
    var samples = [HKQuantitySample]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func HealthKitAuthorizationClicked(_ sender: UIButton) {
        requestHealthKitPermission { (_) in }
    }    
    @IBAction func GetHeartRateClicked(_ sender: UIButton) {
        self.readHeartRate()
    }
    @IBAction func GetEnergyBurnedClicked(_ sender: UIButton) {
        self.readEnergyBurned()
    }
    @IBAction func GetExerciseTimeClicked(_ sender: UIButton) {
        self.readExerciseTime()
    }
    @IBAction func GetSleepAverageClicked(_ sender: UIButton) {
        self.readSleepTime()
    }
    @IBAction func GetUserCharacteristicsClicked(_ sender: UIButton) {
        readCharacteristicsData()
    }

}

