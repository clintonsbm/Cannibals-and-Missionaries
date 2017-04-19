//
//  State.swift
//  Cannibals and Missionaries
//
//  Created by Renan Trévia and Clinton de Sá on 4/7/17.
//  Copyright © 2017 Renan Trévia. All rights reserved.
//

import Foundation

enum Position {
    case right
    case left
}

class State: NSObject {
    
    var cannibalLeft: Int!
    var missionaryLeft: Int!
    var cannibalRight: Int!
    var missionaryRight: Int!
    var boat: Position!
    
    var parentState: State?
    
    init(cannibalsLeft cannibalLeft: Int, missionariesLeft missionaryLeft: Int, withBoatPosition boat: Position, cannibalsRight cannibalRight: Int, missionariesRight missionaryRight: Int) {
        self.cannibalLeft = cannibalLeft
        self.missionaryLeft = missionaryLeft
        self.boat = boat
        self.cannibalRight = cannibalRight
        self.missionaryRight = missionaryRight
    }
    
    func isGoal() -> Bool {
        return cannibalLeft == 0 && missionaryLeft == 0
    }
    
    func isValid() -> Bool {
        if missionaryLeft >= 0 && missionaryRight >= 0 && cannibalLeft >= 0 && cannibalRight >= 0 && (missionaryLeft == 0 || missionaryLeft >= cannibalLeft) && (missionaryRight == 0 || missionaryRight >= cannibalRight) {
            return true
        }
        
        return false
    }
    
    // Talvez eu precise colocar um inout no newState também. Care
    func testAndAdd(_ successors: inout Array<State>, with newState: State) {
        if newState.isValid() {
            newState.parentState = self
            successors.append(newState)
        }
    }
    
    func generateSuccessors() -> Array<State> {
        var successors: Array<State> = Array<State>()
        
        if boat == Position.left {
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft, missionariesLeft: missionaryLeft - 2, withBoatPosition: .right, cannibalsRight: cannibalRight, missionariesRight: missionaryRight + 2))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft - 2, missionariesLeft: missionaryLeft, withBoatPosition: .right, cannibalsRight: cannibalRight + 2, missionariesRight: missionaryRight))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft - 1, missionariesLeft: missionaryLeft - 1, withBoatPosition: .right, cannibalsRight: cannibalRight + 1, missionariesRight: missionaryRight + 1))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft, missionariesLeft: missionaryLeft - 1, withBoatPosition: .right, cannibalsRight: cannibalRight, missionariesRight: missionaryRight + 1))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft - 1, missionariesLeft: missionaryLeft, withBoatPosition: .right, cannibalsRight: cannibalRight + 1, missionariesRight: missionaryRight))
        } else {
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft, missionariesLeft: missionaryLeft + 2, withBoatPosition: .left, cannibalsRight: cannibalRight, missionariesRight: missionaryRight - 2))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft + 2, missionariesLeft: missionaryLeft, withBoatPosition: .left, cannibalsRight: cannibalRight - 2, missionariesRight: missionaryRight))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft + 1, missionariesLeft: missionaryLeft + 1, withBoatPosition: .left, cannibalsRight: cannibalRight - 1, missionariesRight: missionaryRight - 1))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft, missionariesLeft: missionaryLeft + 1, withBoatPosition: .left, cannibalsRight: cannibalRight, missionariesRight: missionaryRight - 1))
            testAndAdd(&successors, with: State(cannibalsLeft: cannibalLeft + 1, missionariesLeft: missionaryLeft, withBoatPosition: .left, cannibalsRight: cannibalRight - 1, missionariesRight: missionaryRight))
        }
        
        return successors
    }
    
    func toString() -> String {
        if boat == Position.left {
            return "\(cannibalLeft!), \(missionaryLeft!), L, \(cannibalRight!), \(missionaryRight!)"
        } else {
            return "\(cannibalLeft!), \(missionaryLeft!), R, \(cannibalRight!), \(missionaryRight!)"
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if !(object is State) {
            return false
        } else {
            let state = object as! State
            return state.cannibalLeft == cannibalLeft && state.missionaryLeft == missionaryLeft && state.boat == boat && state.cannibalRight == cannibalRight && state.missionaryRight == missionaryRight
        }
    }
}
