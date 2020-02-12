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

    var highMiss = "";
    var highScore = "";
    var lowMiss = "";
    var lowScore = "";
    
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
            if let v = self?.gameData.teleMissHigh {
                self?.highMiss = "\(v)"
            }
            self?.highMissedButton.setTitle("High Missed " + (self?.highMiss ?? "0"), for:.normal)
        }
        self.highScoredButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleHitHigh += 1
            if let v = self?.gameData.teleHitHigh {
                self?.highScore = "\(v)"
            }
            self?.highScoredButton.setTitle("High Scored " + (self?.highScore ?? "0"), for:.normal)
        }
        self.lowMissedButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleMissLow += 1
            if let v = self?.gameData.teleMissLow {
                self?.lowMiss = "\(v)"
            }
            self?.lowMissedButton.setTitle("Low Missed " + (self?.lowMiss ?? "0"), for:.normal)
        }
        self.lowScoredButton.didSelectHandler = { [weak self] _ in
            self?.gameData.teleHitLow += 1
            if let v = self?.gameData.teleHitLow {
                self?.lowScore = "\(v)"
            }
            self?.lowScoredButton.setTitle("Low Scored " + (self?.lowScore ?? "0"), for:.normal)
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
