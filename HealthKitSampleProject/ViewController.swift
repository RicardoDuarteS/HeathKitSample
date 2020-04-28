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

    @IBOutlet weak var btnRequestHKAuth: UIButton!
    @IBOutlet weak var btnGetHearthRare: UIButton!
    @IBOutlet weak var btnEnergyBurned: UIButton!
    @IBOutlet weak var btnExerciseTime: UIButton!
    @IBOutlet weak var btnSleepAverage: UIButton!
    @IBOutlet weak var btnGetCharacteristics: UIButton!


    @IBOutlet weak var lblHealthKitStatus: UILabel!
    @IBOutlet weak var lblHeartRate: UILabel!
    @IBOutlet weak var lblEnergyBurned: UILabel!
    @IBOutlet weak var lblExerciseTime: UILabel!
    @IBOutlet weak var lblSleepAverage: UILabel!
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

    func getHeartRate() {
        
    }
    
    @IBAction func GetHeartRateClicked(_ sender: UIButton) {
//        subscribeToHeartBeatChanges()
    }
    @IBAction func GetEnergyBurnedClicked(_ sender: UIButton) {
        self.readEnergyBurned()
    }
    @IBAction func GetExerciseTimeClicked(_ sender: UIButton) {
    }
    @IBAction func GetSleepAverageClicked(_ sender: UIButton) {
    }
    @IBAction func GetUserCharacteristicsClicked(_ sender: UIButton) {
        readCharacteristicsData()
    }

}

