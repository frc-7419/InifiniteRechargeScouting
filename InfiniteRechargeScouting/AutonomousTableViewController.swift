//
//  SandstormTableViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//
import SAPFiori
import UIKit

class AutonomousTableViewController: UITableViewController {
    
    var gameData = ModelObject.shared
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        let switchFormCell = tableView.dequeueReusableCell(withIdentifier: FUISwitchFormCell.reuseIdentifier, for: indexPath) as! FUISwitchFormCell

        let multipleOptionCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let autonOptions = ["0", "1", "2", "3"]

        switch indexPath.row {
        case 0:
            // Row for 'Scored Low2'
            multipleOptionCell.valueOptions = autonOptions

            switch gameData.autonLow {
                case 1:
                    gameData.autonLowIndex = 0
                case 2:
                    gameData.autonLowIndex = 1
            default:
                print("You screwed up at line 41")
            }
            multipleOptionCell.keyName = "Scored Low"
            multipleOptionCell.value = gameData.autonLowIndex
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.autonHighIndex = newValue
                if (newValue == 0) {
                    self.gameData.autonLow = 1
                }
                else {
                    self.gameData.autonLow = 2
                }
            }
            return multipleOptionCell
        case 1:
            // Row for 'Scored High'
            multipleOptionCell.valueOptions = autonOptions

            switch gameData.autonHigh {
                case 1:
                    gameData.autonHighIndex = 0
                case 2:
                    gameData.autonHighIndex = 1
            default:
                print("You screwed up at line 41")
            }
            multipleOptionCell.keyName = "Scored High"
            multipleOptionCell.value = gameData.autonHighIndex
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.autonHighIndex = newValue
                if (newValue == 0) {
                    self.gameData.autonHigh = 1
                }
                else {
                    self.gameData.autonHigh = 2
                }
            }
            return multipleOptionCell
        
        case 2:
            switchFormCell.keyName = "Moved Off Init Line?"
            switchFormCell.value = gameData.moved
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.moved = newValue
            }
            return switchFormCell
        case 3:
            switchFormCell.keyName = "Additional Power Cells?"
            switchFormCell.value = gameData.pickup
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.pickup = newValue
            }
            return switchFormCell
        case 4:
               switchFormCell.keyName = "Additional Shots Scored?"
               switchFormCell.value = gameData.additionalPoints
               switchFormCell.onChangeHandler = { [unowned self] newValue in
                   self.gameData.additionalPoints = newValue
               }
               return switchFormCell
        default:
            return multipleOptionCell
        }
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }
        
        /*
         +----------------------------------------+
         | 🛑 Do not modify code below this line  |
         +----------------------------------------+
         */
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "Autonomous"
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
            let nextVC = UIStoryboard(name: "TeleOp", bundle: nil).instantiateInitialViewController() as! TeleOpViewController
            nextVC.gameData = self.gameData
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }

