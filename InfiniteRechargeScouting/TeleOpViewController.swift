//
//  TeleOp.swift
//  Karans_App
//
//  Created by Karan Saini on 3/8/19.
//  Copyright © 2019 Karan Saini. All rights reserved.
//

import Foundation
import UIKit
import SAPFiori

class TeleOpViewController: UIViewController {
    @IBOutlet var highMissedButton: FUIButton!
    @IBOutlet var highScoredButton: FUIButton!
    @IBOutlet var lowMissedButton: FUIButton!
    @IBOutlet var lowScoredButton: FUIButton!
    
    var gameData = ModelObject.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "TeleOp"

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Sandstorm", style: UIBarButtonItem.Style.done, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton

        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(pushNextViewController(sender:)))
        self.navigationItem.rightBarButtonItem = nextButton

        self.highMissedButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleMissHigh += 1
        }
        self.highScoredButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleHitHigh += 1
        }
        self.lowMissedButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleMissLow += 1
        }
        self.lowScoredButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleHitLow += 1
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    // We want to save data when going back too
    @objc func back(sender: UIBarButtonItem) {
//        self.fillGameData()
        self.navigationController?.popViewController(animated: true)
    }

    @objc func pushNextViewController(sender: UIButton) {
//        fillGameData()
        let nextVC = TotalTableViewController()
//        nextVC.gameData = self.gameData
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
