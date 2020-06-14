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

var timerLabel2 = SKLabelNode()
var (minute2,second2,fragment2) = (0,0,0)

class Chapter2: SKScene, SKPhysicsContactDelegate {
    
    var hole = SKSpriteNode()
    var player = SKSpriteNode()
    var holeCover = SKSpriteNode()
    let motionManager = CMMotionManager()
    var restart = SKSpriteNode()
    var menu = SKSpriteNode()
    var timer = Timer()
    let backgroundMusic = SKAudioNode(fileNamed: "gameBGM.mp3")
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        holeCover = self.childNode(withName: "HoleCover") as! SKSpriteNode
        restart = self.childNode(withName: "Restart") as! SKSpriteNode
        menu = self.childNode(withName: "Menu") as! SKSpriteNode
        timerLabel2 = self.childNode(withName: "TimeLabel") as! SKLabelNode
        self.addChild(backgroundMusic)
        
        // set gyro
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 3, dy: CGFloat((data?.acceleration.y)!) * 3)
        }
        
        //set stopwatch
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(Chapter2.stopWatch), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if restart.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash2(fileNamed: "Splash2Scene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                timerLabel2.text = "00:00.00"
                
            } else if menu.contains(pointOfTouch) {
                
                let sceneMoveTo = SelectLevel(fileNamed: "SelectLevelScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                timerLabel2.text = "00:00.00"
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let playerPositionX = player.position.x
        let playerPositionY = player.position.y
        
        if -80 ... 20 ~= playerPositionX && -560 ... -510 ~= playerPositionY {
            
            holeCover.removeFromParent()
            
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact)  {
        let playerMaze = contact.bodyA
        let finishMaze = contact.bodyB
        let skView = self.view as SKView?
        
        if playerMaze.categoryBitMask == 1 && finishMaze.categoryBitMask == 2 || playerMaze.categoryBitMask == 2 && finishMaze.categoryBitMask == 1 {
            
            let sceneMoveTo = Splash3(fileNamed: "Splash3Scene")
            sceneMoveTo?.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 1)
            skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
            timer.invalidate()
            
        }
        
    }
    
    //func for stopwatch
    @objc func stopWatch(){
        fragment2 += 1
        
        if fragment2 > 99{
            second2 += 1
            fragment2 = 0
            
        } else if second2 > 60 {
            minute2 += 1
            second2 = 0
        }
        
        let secondDoubleString2 = second2 > 9 ? "\(second2)" : "0\(second2)"
        let minuteDoubleString2 = minute2 > 9 ? "\(minute2)" : "0\(minute2)"
        timerLabel2.text = "\(minuteDoubleString2):\(secondDoubleString2).\(fragment2)"
    }
    
    
    
    
}


