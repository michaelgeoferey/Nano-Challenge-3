//
//  Chapter3.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 12/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit
import CoreMotion

var timerLabel3 = SKLabelNode()
var (minute3,second3,fragment3) = (0,0,0)

class Chapter3: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode()
    let motionManager = CMMotionManager()
    var restart = SKSpriteNode()
    var menu = SKSpriteNode()
    var sound = SKSpriteNode()
    var timer = Timer()
    let backgroundMusic = SKAudioNode(fileNamed: "gameBGM.mp3")
    let finishMusic = SKAudioNode(fileNamed: "finish.wav")
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        restart = self.childNode(withName: "Restart") as! SKSpriteNode
        menu = self.childNode(withName: "Menu") as! SKSpriteNode
        sound = self.childNode(withName: "Sound") as! SKSpriteNode
        timerLabel3 = self.childNode(withName: "TimeLabel") as! SKLabelNode
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
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(Chapter3.stopWatch), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if restart.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash3(fileNamed: "Splash3Scene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                (minute3,second3,fragment3) = (0,0,0)
                timerLabel3.text = "00:00.00"
                
            } else if menu.contains(pointOfTouch) {
                
                let sceneMoveTo = SelectLevel(fileNamed: "SelectLevelScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                timer.invalidate()
                (minute3,second3,fragment3) = (0,0,0)
                timerLabel3.text = "00:00.00"
          
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
            
            let sceneMoveTo = Splash4(fileNamed: "Splash4")
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
           fragment3 += 1
           
           if fragment3 > 99{
               second3 += 1
               fragment3 = 0
               
           } else if second3 > 59 {
               minute3 += 1
               second3 = 0
           }
           
           let secondDoubleString3 = second3 > 9 ? "\(second3)" : "0\(second3)"
           let minuteDoubleString3 = minute3 > 9 ? "\(minute3)" : "0\(minute3)"
           timerLabel3.text = "\(minuteDoubleString3):\(secondDoubleString3).\(fragment3)"
       }
       
    
}
