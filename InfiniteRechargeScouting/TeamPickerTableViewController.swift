//
//  TeamPickerViewController.swift
//  FRCScouting
//
//  Created by Takahashi, Alex on 2/15/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import SAPFiori
import UIKit

class TeamPickerTableViewController: FUIFormTableViewController {
    
    // List Picker
    private var multiSelection = false
    private var pickerPromptText = "Select One Item"
    private var teamValues = [0]
    private var scoutValues = [0]
    let teamListOptions = ["1072 – Harker Robotics", "1280 – Ragin' C- Biscuits", "1323 – MadTown Robotics", "1422 – The Neon Knights", "1671 – Buchanan Bird Brains", "1700 – Gatorbotics", "2035 – Robo Rockin' Bots", "2073 – EagleForce", "2085 – RoboDogs", "2135 – Presentation Invasion", "253 – Boba Bots", "254 – The Cheesy Poofs", "2813 – Gear Heads", "2854 – The Prototypes", "3189 – Circuit Breakers", "3303 – Metallic Thunder", "3495 – MindCraft Robotics", "3669 – RoboKnights", "3970 – Duncan Dynamics", "4135 – Iron Patriots", "5026 – Iron Panthers", "5104 – BreakerBots", "5134 – RoboWolves", "5274 – Wolverines", "5419 – Berkelium", "5458 – Digital Minds", "5817 – Uni-Rex", "585 – Cyber Penguins", "5940 – B.R.E.A.D.", "6059 – System Overload Robotics", "6241 – CowTech", "6305 – Stable Circuits", "649 – M-SET Fish", "6506 – Steel Boot", "6619 – GravitechX", "6657 – Arborbotics", "6662 – FalconX", "6711 – Millennial Falcons", "6804 – Team Wolfpack", "6884 – Deep-Space", "6926 – RobotiCats", "6981 – Clockwork Soldiers", "7057 – Titanators", "7419 – QLS Tech Support", "751 – barn2robotics", "7528 – Nuts and Bolts", "7663 – Sleuth Robotics", "8048 – EPA robotics team", "840 – Aragon Robotics Team", "852 – Athenian Robotics", "973 – Greybots"]
    let scoutListOptions = ["Wesley", "Karan", "Neha"]
    var allowsEmptySelection = false
    var isUndoEnabled = false
    var isSearchEnabled = false
    var isEditable = true
    
    // Value Picker
    var valuePickerCell: FUIValuePickerFormCell?
    
    var ROUNDS = 200
    
    var valueOptions = [String]()
    
    var gameData = ModelObject.shared
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteCell = tableView.dequeueReusableCell(withIdentifier: FUINoteFormCell.reuseIdentifier, for: indexPath) as! FUINoteFormCell
        
        // List Picker
        let listPickerCell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIValuePickerFormCell.reuseIdentifier, for: indexPath) as! FUIValuePickerFormCell
        
        let multipleOptionCell = self.tableView.dequeueReusableCell(withIdentifier: FUISegmentedControlFormCell.reuseIdentifier, for: indexPath) as! FUISegmentedControlFormCell
        let startingPosition = ["L","M","R"]
        let redPos = ["Red1","Red2","Red3"]
        let bluePos = ["Blue1","Blue2","Blue3"]
        let preloads = ["0","1","2","3"]
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                listPickerCell.keyName = "Scout:"
                listPickerCell.value = [scoutListOptions.firstIndex(of: gameData.scoutName) ?? 0]
                listPickerCell.isEditable = isEditable
                listPickerCell.allowsMultipleSelection = multiSelection
                listPickerCell.allowsEmptySelection = allowsEmptySelection
                listPickerCell.valueLabel.text = descriptionForSelectedStrings(scoutListOptions, at: scoutValues)
                listPickerCell.isUndoEnabled = isUndoEnabled
                listPickerCell.valueOptions = scoutListOptions
                listPickerCell.onChangeHandler = { [unowned self] newValues in
                    self.scoutValues = newValues
                    self.gameData.scoutName = self.scoutListOptions[listPickerCell.value[0]]
                    NSLog("Picked scout name \(self.gameData.scoutName)")
                }
                self.gameData.scoutName = self.scoutListOptions[listPickerCell.value[0]]
                listPickerCell.listPicker.prompt = pickerPromptText
                listPickerCell.listPicker.isSearchEnabled = isSearchEnabled
                return listPickerCell
            case 1:
                
                listPickerCell.keyName = "Team:"
                listPickerCell.value = [teamListOptions.firstIndex(of: gameData.teamName) ?? 0]
                listPickerCell.isEditable = isEditable
                listPickerCell.allowsMultipleSelection = multiSelection
                listPickerCell.allowsEmptySelection = allowsEmptySelection
                listPickerCell.valueLabel.text = descriptionForSelectedStrings(teamListOptions, at: teamValues)
                listPickerCell.isUndoEnabled = isUndoEnabled
                listPickerCell.valueOptions = teamListOptions
                listPickerCell.onChangeHandler = { [unowned self] newValues in
                    self.teamValues = newValues
                    self.gameData.teamName = self.teamListOptions[listPickerCell.value[0]]
                    NSLog("Picked team name \(self.gameData.teamName)")
                }
                self.gameData.teamName = self.teamListOptions[listPickerCell.value[0]]
                listPickerCell.listPicker.prompt = pickerPromptText
                listPickerCell.listPicker.isSearchEnabled = isSearchEnabled
                return listPickerCell
                
            case 2:
                valuePickerCell = cell // keep reference for onChangeHandler
                cell.keyName = "Match Number"
                cell.valueOptions = valueOptions
                cell.value = self.gameData.match - 1 <= 0 ? 0 : self.gameData.match - 1  // index of first value as default
                cell.onChangeHandler = { newValue in
                    print("Selected value option: \(self.valueOptions[newValue])")
                    self.gameData.match = newValue + 1
                }
                
                return cell
            case 3:
                multipleOptionCell.valueOptions = startingPosition
                multipleOptionCell.keyName = "Initial Position"
                multipleOptionCell.value = gameData.initPos
                multipleOptionCell.isEditable = true
                multipleOptionCell.onChangeHandler = { newValue in
                    self.gameData.initPos = newValue

                }
                return multipleOptionCell
            case 4,5:
                multipleOptionCell.valueOptions = indexPath.row == 4 ? redPos : bluePos
                multipleOptionCell.keyName = indexPath.row == 4 ? "Team Position" : ""
                multipleOptionCell.value = indexPath.row == 4 ? gameData.teamPos : gameData.teamPos - 3
                multipleOptionCell.isEditable = true
                multipleOptionCell.onChangeHandler = { newValue in
                    self.gameData.teamPos = indexPath.row == 4 ? newValue : newValue + 3
                    self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0),IndexPath(row: 5, section: 0)], with: .automatic)
                }
                return multipleOptionCell
            case 6:
                multipleOptionCell.valueOptions = preloads
                multipleOptionCell.keyName = "Preloads"
                multipleOptionCell.value = gameData.initPos
                multipleOptionCell.isEditable = true
                multipleOptionCell.onChangeHandler = { newValue in
                    self.gameData.preload = newValue

                }
                return multipleOptionCell
            default:
                print ("error")
            }
        default:
            print ("error")
        }
        return listPickerCell
    }
    
    func descriptionForSelectedStrings(_ options: [String], at indexes: [Int]) -> String {
        let selectedValues = indexes.map { index in
            return options[index]
        }
        return selectedValues.joined(separator: ", ")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
        return 7
    }
    
    /*
     +----------------------------------------+
     | 🛑 Do not modify code below this line  |
     +----------------------------------------+
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Configure"
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        for n in 1...ROUNDS{
            valueOptions.append(String(n))
        }
        
        // Set some initial values
        // Team name
        self.gameData.teamName = self.teamListOptions[0]
        self.gameData.scoutName = self.scoutListOptions[0];
        
        // Team number
        if let matchNo = Int(valueOptions[0]) {
            self.gameData.match = matchNo - 1
        }
        tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        
        // List Picker
        tableView.register(FUIListPickerFormCell.self, forCellReuseIdentifier: FUIListPickerFormCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        // Value Picker
        tableView.register(FUIValuePickerFormCell.self, forCellReuseIdentifier: FUIValuePickerFormCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44.5
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(FUISegmentedControlFormCell.self, forCellReuseIdentifier: FUISegmentedControlFormCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44.5
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.gameData = ModelObject.shared
        if self.gameData.teamName.isEmpty {
            self.teamValues = [0]
        }
        if self.gameData.scoutName.isEmpty {
            self.scoutValues = [0]
        }
        self.tableView.reloadData()
    }
    
    @objc func pushNextViewController(sender: UIButton) {

        //let nextVC = TeleOpViewController()
        let nextVC = AutonomousTableViewController()
        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
