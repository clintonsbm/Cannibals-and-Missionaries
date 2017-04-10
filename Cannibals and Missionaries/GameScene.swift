//
//  GameScene.swift
//  Cannibals and Missionaries
//
//  Created by Renan Trévia on 4/7/17.
//  Copyright © 2017 Renan Trévia. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let initialState = State(cannibalsLeft: 3, missionariesLeft: 3, withBoatPosition: Position.left, cannibalsRight: 0, missionariesRight: 0)
        
//        executeBFS(withInitialState: initialState)
        executeDLS(withInitialState: initialState)
    }
    
    // MARK: - TOUCH DELEGATE 01
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    // MARK: - TOUCH DELEGATE 02
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: - UPDATE
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    // MARK: - CANNIBALS AND MISSIONARIES FUNCTIONS
    
    func executeBFS(withInitialState initialState: State) {
        let search = BreadthFirstSearch()
        let solution = search.execute(initialState)
        printSolution(ofState: solution)
    }
    
    func executeDLS(withInitialState initialstate: State) {
        let search = DepthLimitedSearch()
        let solution = search.execute(initialstate)
        printSolution(ofState: solution)
    }
    
    func printSolution(ofState solution: State?) {
        if solution == nil {
            print("No solution found")
        } else {
            print("C  M  B  C  M")
            var path = Array<State>()
            var state = solution
            
            while state != nil {
                path.append(state!)
                state = state?.parentState
            }
            
            let depth = path.count - 1
            
            for index in (0...depth).reversed() {
                state = path[index]
                
                if (state?.isGoal())! {
                    print(String(describing: state!.toString()))
                } else {
                    print("\(String(describing: state!.toString()))")
                }
            }
            print("Depth: \(depth)")
        }
    }
}
