//
//  ModelObject.swift
//  FRCScouting
//
//  Created by Wesley Vong on 3/10/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import Foundation

class ModelObject {
    
    static private(set) var shared = ModelObject()
    
    private init() { }
    
    func reset() {
        ModelObject.shared = ModelObject()
    }
    // Team Selector
    var teamName = ""
    var match = 0
    
    // Auton
    // Position where 0 is left of target, 1 is in front of target, 2 is right of the target when facing the target
    var initPos = 0
    var crossedInit = false
    
    var autonHigh = 0
    var autonLow = 0
    var pickedUp = 0
    var preload = 0
    var collision = false
    
    // Teleop
    var teleHigh = 0
    var teleLow = 0
    var rotationAttempt = false
    var rotationSuccess = false
    var rotationTime = 0.0
    var positionAttempt = false
    var positionSuccess = false
    var positionTime = 0.0
    
    //Endgame
    var parked = false
    var hangSuccess = false
    var level = false
    
    /* Percent shots made High in Auton and Teleop
        Percent shots made Low in Auton and Teleop
        shots missed vs shots scored
        Swipe to switch Screen
        
     
     4 Page app
     Swipe between screen
     Page 1: Prematch
     Page 2: Auto – Shots only, 4 buttons High hit, high missed, low hit, low missed with possible additional functionality
     Page 3: TeleOp – Shots only, 4 buttons High hit, high missed, low hit, low missed with possible additional functionality
     Page 4: Postmatch – Wheel Multiselect – (messed up, color, rotation, none), Near shots, Far shots Did they hang, was it balanced? Fancy Hang – Hang with movement/ Hang with assistance, Disconnected?, Fall Over?*/
//
//    // Auton
//    var skyStoneDel = 0
//    var skyStonePla = 0
//    var autonStoneDel = 0
//    var autonStonePla = 0
//    var foundationRep = false
//
//    // Teleop
//    var stoneDel = 0
//    var stonePla = 0
//
//    // EndGame
//    var foundationMv = false
//    var highTower = 0
//    var maxCap = false
//    var capTower = 0
//    var parked = false
    
}

// Helper to convert Ints to bool
// Where false is 0 and 1 is true
public extension Int {
    public init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}
