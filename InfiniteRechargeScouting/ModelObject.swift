//
//  ModelObject.swift
//  FRCScouting
//
//  Created by Wesley Vong on 3/10/19.
//  Copyright © 2019 Takahashi, Alex. All rights reserved.
//

import Foundation

class ModelObject: Codable {
    
    static private(set) var shared = ModelObject()
    
    private init() { }
    
    func reset() {
        ModelObject.shared = ModelObject()
    }
    // Pre-Match
    var scoutName = ""
    var teamName = ""
    var match = 0
    var preload = 0
    var initPos = 0
    var teamPos = 0
    
    // Auton
    var autonHigh = 0
    var autonLow = 0
    var moved = false
    var pickup = false
    var additionalPoints = false

    
    // Teleop
    var teleHitHigh = 0
    var teleHitLow = 0
    var teleMissHigh = 0
    var teleMissLow = 0
    
    // Post-Match
    var disconnect = false
    var fall = false
    var trench = false
    var colorWheel = ""
    var shotDistance = ""
    var hang = ""
    var driverPerformance = 0 // 0 = meh, 1 = average, 2 = great
    var penalties = false
    
//    // Color Wheel Select
//    var messedUp = false;
//    var color = false;
//    var rotation = false;
//    var noneColorWheel = false;
    
//    // Shot Select
//    var nearShot = false
//    var farShot = false;
//
//    // Hang
//    var hang = false;
//    var balanced = false;
//    var failed = false;
//    var parked = false;
//    var outOfZone = false;

}

// Helper to convert Ints to bool
// Where false is 0 and 1 is true
public extension Int {
    public init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}
