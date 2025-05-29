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
        setupShip()
    }
    
    // constraints on screen for ship
    func setupShip() {
        guard let ship = childNode(withName: "ship") as? SKSpriteNode else { return }
        let xRange = SKRange(lowerLimit: -((frame.width / 2) - ship.frame.width),
                             upperLimit: (frame.width / 2) - ship.frame.width)
        let yRange = SKRange(lowerLimit: -(frame.height / 2) + 100,
                             upperLimit: frame.width / 4)
        let constraint = SKConstraint.positionX(xRange, y: yRange)
        ship.constraints = [constraint]
    }
    
    // player's weapon
    func fireLaser() {
        guard let ship = childNode(withName: "ship") as? SKSpriteNode else { return }
        
        let laser = SKShapeNode(rectOf: CGSize(width: 3, height: 30))
        laser.fillColor = .yellow
        laser.strokeColor = .clear
        laser.blendMode = .add
        laser.zPosition = 4
        
        laser.position = CGPoint(x: ship.position.x, y: ship.position.y)
        
        addChild(laser)
        
        let moveAction = SKAction.moveTo(y: frame.height + laser.frame.height, duration: 2)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveAction, remove])
        
        laser.run(sequence)
    }
    
    // executed with every new frame
    override func update(_ currentTime: TimeInterval) {
        moveScroll(layer: 0, scrollSpeed: 50)
        moveScroll(layer: 1, scrollSpeed: 70)
        moveScroll(layer: 2, scrollSpeed: 100)
    }
    
    // move background to create a scroll effect
    func moveScroll(layer: Int, scrollSpeed: CGFloat) {
        guard let scroll1 = childNode(withName: "background\(layer)1") as? SKSpriteNode,
              let scroll2 = childNode(withName: "background\(layer)2") as? SKSpriteNode else { return }
        
        let deltaTime = 1 / 60.0  // calculate scroll speed, based on 60fps
        scroll1.position.y -= scrollSpeed * CGFloat(deltaTime)
        scroll2.position.y -= scrollSpeed * CGFloat(deltaTime)
        
        // detect when background1 has disappeared from screen and move it back to top
        if scroll1.position.y <= -scroll1.size.height {
            scroll1.position.y = scroll2.position.y + scroll2.size.height
        }
        
        if scroll2.position.y <= -scroll2.size.height {
            scroll2.position.y = scroll1.position.y + scroll1.size.height
        }
    }
    
    // player's attack
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else { return } // check if the screen has been touched
        fireLaser()
    }
    
    // move the ship based on user's touch
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let ship = childNode(withName: "ship") as? SKSpriteNode else { return } // ship position
        
        let currentPosition = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        
        let deltaX = currentPosition.x - previousPosition.x
        let deltaY = currentPosition.y - previousPosition.y
        
        let acceleration: CGFloat = 1.5
        
        ship.position.x += deltaX * acceleration
        ship.position.y += deltaY * acceleration
    }
}
