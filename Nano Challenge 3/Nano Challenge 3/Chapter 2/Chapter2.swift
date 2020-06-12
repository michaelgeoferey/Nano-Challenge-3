//
//  Chapter2.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 12/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class Chapter2: SKScene, SKPhysicsContactDelegate {
    
    var hole = SKSpriteNode()
    var player = SKSpriteNode()
    var holeCover = SKSpriteNode()
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        holeCover = self.childNode(withName: "HoleCover") as! SKSpriteNode
        
        // set gyro
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 3, dy: CGFloat((data?.acceleration.y)!) * 3)
            
            
        }
    }
    
    //set game finish
    func didBegin(_ contact: SKPhysicsContact)  {
        let playerMaze = contact.bodyA
        let finishMaze = contact.bodyB
        
        if playerMaze.categoryBitMask == 1 && finishMaze.categoryBitMask == 2 || playerMaze.categoryBitMask == 2 && finishMaze.categoryBitMask == 1 {
            
            print("Finish")
            
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        
        let playerPositionX = player.position.x
        let playerPositionY = player.position.y
        
        if -80 ... 20 ~= playerPositionX && -560 ... -510 ~= playerPositionY {
           
            holeCover.removeFromParent()
            
            
        }
    }
        
}
    

