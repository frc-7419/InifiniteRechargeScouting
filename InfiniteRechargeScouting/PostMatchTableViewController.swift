//
//  SandstormTableViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//
import SAPFiori
import UIKit

class PostMatchTableViewController: UITableViewController {
    
    var gameData = ModelObject.shared
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        let switchFormCell = tableView.dequeueReusableCell(withIdentifier: FUISwitchFormCell.reuseIdentifier, for: indexPath) as! FUISwitchFormCell

        let multipleOptionCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell

        let colorWheelOptions = ["No Attempt", "Rotation", "Color", "Failed"]
        
        let shotDistanceOptions = ["Near", "Far", "Both"]
        
        let hangOptions = ["No", "Yes", "Balanced", "Failed", "Parked"]
        
        let rankOptions = ["1", "2", "3"]

        switch indexPath.row {
          case 0:
              switchFormCell.keyName = "Disconnect?"
              switchFormCell.value = gameData.disconnect
              switchFormCell.onChangeHandler = { [unowned self] newValue in
                  self.gameData.disconnect = newValue
              }
              return switchFormCell
        case 1:
            switchFormCell.keyName = "Fell Over?"
            switchFormCell.value = gameData.fall
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.fall = newValue
            }
            return switchFormCell
        case 2:
            multipleOptionCell.valueOptions = colorWheelOptions
            multipleOptionCell.keyName = "Color Wheel"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { [unowned self] newValue in
                if (newValue == 0) {
                    self.gameData.colorWheel = "No Attempt"
                }
                else if (newValue == 1) {
                    self.gameData.colorWheel = "Rotation"
                }
                else if (newValue == 2) {
                    self.gameData.colorWheel = "Color"
                }
                else {
                    self.gameData.colorWheel = "Failed"
                }
            }
            return multipleOptionCell
        case 3:
            multipleOptionCell.valueOptions = shotDistanceOptions
            multipleOptionCell.keyName = "Shot Distance"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { [unowned self] newValue in
                if (newValue == 0) {
                    self.gameData.shotDistance = "Near"
                }
                else if (newValue == 1) {
                    self.gameData.shotDistance = "Far"
                }
                else {
                    self.gameData.shotDistance = "Both"
                }
            }
            return multipleOptionCell
        case 4:
           multipleOptionCell.valueOptions = hangOptions
           multipleOptionCell.keyName = "Hang"
           multipleOptionCell.isEditable = true
           multipleOptionCell.onChangeHandler = { [unowned self] newValue in
               if (newValue == 0) {
                   self.gameData.hang = "No"
               }
               else if (newValue == 1) {
                   self.gameData.hang = "Yes"
               }
               else if (newValue == 2) {
                   self.gameData.hang = "Balanced"
               }
               else if (newValue == 3) {
                   self.gameData.colorWheel = "Failed"
               }
               else {
                   self.gameData.colorWheel = "Parked"
               }
                
            }
            return multipleOptionCell
        case 5:
            switchFormCell.keyName = "Under Trench?"
            switchFormCell.value = gameData.trench
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.trench = newValue
            }
            return switchFormCell
        case 6:
            multipleOptionCell.valueOptions = rankOptions
            multipleOptionCell.keyName = "Driver Performance"
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { [unowned self] newValue in
                if (newValue == 0) {
                    self.gameData.driverPerformance = 1
                }
                else if (newValue == 1) {
                    self.gameData.driverPerformance = 2
                }
                else {
                    self.gameData.driverPerformance = 3
                }
            }
            return multipleOptionCell
        case 7:
            switchFormCell.keyName = "Penalties?"
            switchFormCell.value = gameData.penalties
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.penalties = newValue
            }
            return switchFormCell
        default:
            return multipleOptionCell
        }
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 8
        }

        /*
         +----------------------------------------+
         | 🛑 Do not modify code below this line  |
         +----------------------------------------+
         */

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Post Match"
            let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
            self.navigationItem.rightBarButtonItem = nextButton

            // Selection Buttons
            tableView.register(FUISegmentedControlFormCell.self, forCellReuseIdentifier: FUISegmentedControlFormCell.reuseIdentifier)

            // Switcher
            tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)

            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none

            tableView.estimatedRowHeight = 180
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
        }

        @objc func pushNextViewController(sender: UIButton) {
            let nextVC = UIStoryboard.init(name: "TeleOp", bundle: Bundle.main).instantiateViewController(withIdentifier: "TeleOpViewController") as! TeleOpViewController
            nextVC.gameData = self.gameData
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }

