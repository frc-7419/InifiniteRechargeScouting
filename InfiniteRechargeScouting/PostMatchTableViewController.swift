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

        switch indexPath.row {
          case 0:
              switchFormCell.keyName = "Did Robot DC?"
              switchFormCell.value = gameData.disconnect
              switchFormCell.onChangeHandler = { [unowned self] newValue in
                  self.gameData.disconnect = newValue
              }
              return switchFormCell
        case 1:
           switchFormCell.keyName = "Did Robot Fall Over?"
            switchFormCell.value = gameData.fall
            switchFormCell.onChangeHandler = { [unowned self] newValue in
                self.gameData.fall = newValue
            }
            return switchFormCell
        case 2:
            // Row for 'Scored High'
            multipleOptionCell.valueOptions = colorWheelOptions
            multipleOptionCell.keyName = "Color Wheel"
            multipleOptionCell.value = gameData.colorWheelIndex
            multipleOptionCell.isEditable = true
            multipleOptionCell.onChangeHandler = { newValue in
                self.gameData.autonHighIndex = self.gameData.autonHigh
            }
            return multipleOptionCell
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

