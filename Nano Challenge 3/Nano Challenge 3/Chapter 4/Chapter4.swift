//
//  Chapter4.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 13/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit
import CoreMotion

var timerLabel4 = SKLabelNode()
var (minute4,second4,fragment4) = (0,0,0)

class Chapter4: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode()
    var yellowDoor = SKSpriteNode()
    var pinkDoor = SKSpriteNode()
    let motionManager = CMMotionManager()
    var restart = SKSpriteNode()
    var menu = SKSpriteNode()
    var timer = Timer()
    let backgroundMusic = SKAudioNode(fileNamed: "gameBGM.mp3")
    let finishMusic = SKAudioNode(fileNamed: "finish.wav")
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        yellowDoor = self.childNode(withName: "DoorYellow") as! SKSpriteNode
        pinkDoor = self.childNode(withName: "DoorPink") as! SKSpriteNode
        restart = self.childNode(withName: "Restart") as! SKSpriteNode
        menu = self.childNode(withName: "Menu") as! SKSpriteNode
        timerLabel4 = self.childNode(withName: "TimeLabel") as! SKLabelNode
        self.addChild(backgroundMusic)
        finishMusic.autoplayLooped = false
        self.addChild(finishMusic)
        
        // set gyro
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 3, dy: CGFloat((data?.acceleration.y)!) * 3)
        }
        
        //set stopwatch
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(Chapter4.stopWatch), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if restart.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash4(fileNamed: "Splash4")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                timerLabel4.text = "00:00.00"
                
            } else if menu.contains(pointOfTouch) {
                
                let sceneMoveTo = SelectLevel(fileNamed: "SelectLevelScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                timerLabel4.text = "00:00.00"
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let playerPositionX = player.position.x
        let playerPositionY = player.position.y
        
        if 110 ... 150 ~= playerPositionX && -110 ... -70 ~= playerPositionY {
            
            pinkDoor.removeFromParent()
            
        }
        
        if 225 ... 265 ~= playerPositionX && -510 ... -475 ~= playerPositionY {
            
            yellowDoor.removeFromParent()
            
        }
    }
    
    //set game finish
    func didBegin(_ contact: SKPhysicsContact)  {
        let playerMaze = contact.bodyA
        let finishMaze = contact.bodyB
        let skView = self.view as SKView?
        
        if playerMaze.categoryBitMask == 1 && finishMaze.categoryBitMask == 2 || playerMaze.categoryBitMask == 2 && finishMaze.categoryBitMask == 1 {
            
            let sceneMoveTo = SelectLevel(fileNamed: "SelectLevelScene")
            sceneMoveTo?.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 1)
            let pauseBGM = SKAction.run {
                self.backgroundMusic.run(SKAction.stop())
            }
            let playBGM = SKAction.run {
                self.finishMusic.run(SKAction.play())
            }
            let sequence = SKAction.sequence(
                [pauseBGM,playBGM,SKAction.wait(forDuration: 1),
                SKAction.run {
                    skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                }])
            run(sequence)
            timer.invalidate()
            
        }
    }
    
    //func for stopwatch
    @objc func stopWatch(){
        fragment4 += 1
        
        if fragment4 > 99{
            second4 += 1
            fragment4 = 0
            
        } else if second4 > 60 {
            minute4 += 1
            second4 = 0
        }
        
        let secondDoubleString4 = second4 > 9 ? "\(second4)" : "0\(second4)"
        let minuteDoubleString4 = minute4 > 9 ? "\(minute4)" : "0\(minute4)"
        timerLabel4.text = "\(minuteDoubleString4):\(secondDoubleString4).\(fragment4)"
    }
}
