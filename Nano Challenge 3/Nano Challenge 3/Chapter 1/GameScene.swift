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
    var restart = SKSpriteNode()
    var menu = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        endNode = self.childNode(withName: "FinishBound") as! SKSpriteNode
        restart = self.childNode(withName: "Restart") as! SKSpriteNode
        menu = self.childNode(withName: "Menu") as! SKSpriteNode
        
        // set gyro
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 3, dy: CGFloat((data?.acceleration.y)!) * 3)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if restart.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash1(fileNamed: "Splash1Scene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                
            } else if menu.contains(pointOfTouch) {
                
                let sceneMoveTo = SelectLevel(fileNamed: "SelectLevelScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
            }
        }
    }
    
    //set game finish
    func didBegin(_ contact: SKPhysicsContact)  {
        let playerMaze = contact.bodyA
        let finishMaze = contact.bodyB
        let skView = self.view as SKView?
        
        if playerMaze.categoryBitMask == 1 && finishMaze.categoryBitMask == 2 || playerMaze.categoryBitMask == 2 && finishMaze.categoryBitMask == 1 {
            
            let sceneMoveTo = Splash2(fileNamed: "Splash2Scene")
            sceneMoveTo?.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 1)
            skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
            
        }
    }
    
}

