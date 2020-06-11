//
//  GameScene.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 09/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let motionManager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    var panel = SKSpriteNode()


    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        panel = self.childNode(withName: "panel") as! SKSpriteNode
        endNode = self.childNode(withName: "finishMaze") as! SKSpriteNode
        
// set gyro
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0
        motionManager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 3, dy: CGFloat((data?.acceleration.y)!) * 3)
            
        }
        
    }
    
//set game finish
    func didBegin(_ contact: SKPhysicsContact) {
        let playerMaze = contact.bodyA
        let finishMaze = contact.bodyB
        
        if playerMaze.categoryBitMask == 1 && finishMaze.categoryBitMask == 2 || playerMaze.categoryBitMask == 2 && finishMaze.categoryBitMask == 1 {
            print("You Won")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        let xPlayer = player.position.x
        let yPlayer = player.position.y
        if  0 ... 240 ~= xPlayer && -720 ... -610 ~= yPlayer {
            panel.removeFromParent()
        }
    }
}
