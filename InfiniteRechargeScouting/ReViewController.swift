//
//  ReViewController.swift
//  FRCScouting
//
//  Created by Ayush Bajaj on 3/26/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import UIKit
import Foundation
import SAPFoundation
import SAPFiori

class ReViewController: FUIFormTableViewController {
    
    var gameData = ModelObject.shared
    @objc func showResetAlert(sender: UIButton) {
        let alertController = UIAlertController(title: "Are You Sure?", message: "Going back home will erase any entered data", preferredStyle: .alert)

        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            //Reset data
            self.gameData.reset()
            self.navigationController?.popToRootViewController(animated: true)
        }

        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            return
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)

    }

    @objc func showDataWipeAlert() {
        let alertController = UIAlertController(title: "Confirm", message: "Do you want to delete previous match data", preferredStyle: .alert)

        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            let url = NSURL(fileURLWithPath: path)
//            if let pathComponent = url.appendingPathComponent(self.csvFileTitle) {
//                do {
//                    try FileManager.default.removeItem(at: pathComponent)
//                } catch {
//                    FUIToastMessage.show(message: "Could not delete file!")
//                }
//
//                FUIToastMessage.show(message: "File deleted")
                self.gameData.reset()
                self.navigationController?.popToRootViewController(animated: true)
//            } else {
//                FUIToastMessage.show(message: "Could not delete file!")
//            }
        }

        let action2 = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction) in
            return
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)

    }
    func save(){
        var gameData = ModelObject.shared
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self.gameData)
        
        let url = URL(string: "https://script.google.com/macros/s/AKfycbweSRv4K89o9c1lzbJGP1wSGCLNCoODeqdXzkeBgubE7eKBdF_l/exec")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                print(error?.localizedDescription ?? "No data")
                FUIToastMessage.show(message: "Error!")
                return
            }
            print(response.statusCode);
            if (response.statusCode == 200){
                FUIToastMessage.show(message: "Success!")
            } else {
                FUIToastMessage.show(message: "Error!")
            }
        }

        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Review"
        let nextButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(showResetAlert))
        self.navigationItem.rightBarButtonItem = nextButton

        tableView.register(FUISwitchFormCell.self, forCellReuseIdentifier: FUISwitchFormCell.reuseIdentifier)
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        tableView.register(FUIMapDetailPanel.ButtonTableViewCell.self, forCellReuseIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return the number of cells
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement FUI Form Cells
        /* let cell = UITableViewCell()
         cell.textLabel?.text = "TODO: Add FUI Form Cells"
         return cell */


        let switchFormCell = tableView.dequeueReusableCell(withIdentifier: FUISwitchFormCell.reuseIdentifier, for: indexPath) as! FUISwitchFormCell
        let grandTextFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        let penaltyPoints = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        let noteCell = tableView.dequeueReusableCell(withIdentifier: FUINoteFormCell.reuseIdentifier, for: indexPath) as! FUINoteFormCell
        let saveButton = tableView.dequeueReusableCell(withIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier, for: indexPath) as! FUIMapDetailPanel.ButtonTableViewCell
        let textFieldCell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
        let exportButton = tableView.dequeueReusableCell(withIdentifier: FUIMapDetailPanel.ButtonTableViewCell.reuseIdentifier, for: indexPath) as! FUIMapDetailPanel.ButtonTableViewCell




        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                saveButton.button.setTitle("Save", for: .normal)
                saveButton.button.didSelectHandler = { btn in
                    self.save()
                }
                return saveButton
            default:
                switchFormCell.value = true
                switchFormCell.keyName = "Error"
                return switchFormCell
            }

        default:
            switchFormCell.value = true
            switchFormCell.keyName = "Error"
            return switchFormCell
        }
    }
    
    
}

extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}

