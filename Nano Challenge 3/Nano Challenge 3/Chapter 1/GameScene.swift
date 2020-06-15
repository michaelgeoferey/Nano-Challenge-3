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

var timerLabel = SKLabelNode()
var (minute,second,fragment) = (0,0,0)
var btnCount = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let motionManager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    var restart = SKSpriteNode()
    var menu = SKSpriteNode()
    var sound = SKSpriteNode()
    var timer = Timer()
    let backgroundMusic = SKAudioNode(fileNamed: "gameBGM.mp3")
    let finishMusic = SKAudioNode(fileNamed: "finish.wav")
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        endNode = self.childNode(withName: "FinishBound") as! SKSpriteNode
        restart = self.childNode(withName: "Restart") as! SKSpriteNode
        menu = self.childNode(withName: "Menu") as! SKSpriteNode
        sound = self.childNode(withName: "Sound") as! SKSpriteNode
        timerLabel = self.childNode(withName: "TimeLabel") as! SKLabelNode
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
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(stopWatch), userInfo: nil, repeats: true)
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
                timer.invalidate()
                (minute,second,fragment) = (0,0,0)
                timerLabel.text = "00:00.00"
                
            } else if menu.contains(pointOfTouch) {
                
                let sceneMoveTo = SelectLevel(fileNamed: "SelectLevelScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                (minute,second,fragment) = (0,0,0)
                timerLabel.text = "00:00.00"
                
       //func for mute sound
            } else if sound.contains(pointOfTouch){
               btnCount += 1
                if btnCount % 2 == 0 {
                    backgroundMusic.run(SKAction.play())
                    sound.run(SKAction.fadeAlpha(to: 1, duration: 0))
                } else {
                    backgroundMusic.run(SKAction.stop())
                    sound.run(SKAction.fadeAlpha(to: 0, duration: 0))
                }
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
            let sceneTransition = SKTransition.fade(withDuration: 3)
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
        fragment += 1
        
        if fragment > 99{
            second += 1
            fragment = 0
            
        } else if second > 59 {
            minute += 1
            second = 0
        }
        
        let secondDoubleString = second > 9 ? "\(second)" : "0\(second)"
        let minuteDoubleString = minute > 9 ? "\(minute)" : "0\(minute)"
        timerLabel.text = "\(minuteDoubleString):\(secondDoubleString).\(fragment)"
    }
    
}

