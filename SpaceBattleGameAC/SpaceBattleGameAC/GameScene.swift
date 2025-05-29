//
//  GameScene.swift
//  SpaceBattleGameAC
//  Logic of our game
//  Created by Uri on 8/3/25.
//

import SwiftUI
import SpriteKit

final class GameScene: SKScene {
    
    // Constructor for our game
    static let newGame: GameScene = {
        guard let game = GameScene(fileNamed: "GameScene.sks") else { fatalError() }
        game.scaleMode = .aspectFill
        return game
    }()
    
    // initialize our game components
    override func didMove(to view: SKView) {
        //
    }
    
    // move the ship based on user's touch
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
        let ship = childNode(withName: "ship") as? SKSpriteNode else { return }
        
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        
        let deltaX = currentPosition.x - previousPosition.x
        let deltaY = currentPosition.y - previousPosition.y
        
        let acceleration: CGFloat = 2.0
        
        ship.position.x += deltaX * acceleration
        ship.position.y += deltaY * acceleration
    }
}
