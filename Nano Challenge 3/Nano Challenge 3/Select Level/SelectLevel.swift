//
//  SelectLevel.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 13/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit

class SelectLevel: SKScene {
    
    var chapter1 = SKSpriteNode()
    var chapter2 = SKSpriteNode()
    var chapter3 = SKSpriteNode()
    var chapter4 = SKSpriteNode()
    var timeLabel1 = SKLabelNode()
    var timeLabel2 = SKLabelNode()
    var timeLabel3 = SKLabelNode()
    var timeLabel4 = SKLabelNode()
    var chapterSoon = SKSpriteNode()
    let clickSound = SKAudioNode(fileNamed: "click.wav")
    
    
    override func didMove(to view: SKView) {
        
        chapter1 = self.childNode(withName: "Chapter1") as! SKSpriteNode
        chapter2 = self.childNode(withName: "Chapter2") as! SKSpriteNode
        chapter3 = self.childNode(withName: "Chapter3") as! SKSpriteNode
        chapter4 = self.childNode(withName: "Chapter4") as! SKSpriteNode
        timeLabel1 = self.childNode(withName: "BestTime1") as! SKLabelNode
        timeLabel2 = self.childNode(withName: "BestTime2") as! SKLabelNode
        timeLabel3 = self.childNode(withName: "BestTime3") as! SKLabelNode
        timeLabel4 = self.childNode(withName: "BestTime4") as! SKLabelNode
        chapterSoon = self.childNode(withName: "ChapterSoon") as! SKSpriteNode
        clickSound.autoplayLooped = false
        self.addChild(clickSound)
        
        //set best time1
        //        let defaults = UserDefaults()
        //        var bestTime1 = defaults.integer(forKey: "bestTimeSaved")
        let secondDoubleString = second > 9 ? "\(second)" : "0\(second)"
        let minuteDoubleString = minute > 9 ? "\(minute)" : "0\(minute)"
        timeLabel1.text = ("\(minuteDoubleString):\(secondDoubleString).\(fragment)")
        
        //set best time2
        let secondDoubleString2 = second2 > 9 ? "\(second2)" : "0\(second2)"
        let minuteDoubleString2 = minute2 > 9 ? "\(minute2)" : "0\(minute2)"
        timeLabel2.text = ("\(minuteDoubleString2):\(secondDoubleString2).\(fragment2)")
        
        //set best time3
        let secondDoubleString3 = second3 > 9 ? "\(second3)" : "0\(second3)"
        let minuteDoubleString3 = minute3 > 9 ? "\(minute3)" : "0\(minute3)"
        timeLabel3.text = ("\(minuteDoubleString3):\(secondDoubleString3).\(fragment3)")
        
        //set best time4
        let secondDoubleString4 = second4 > 9 ? "\(second4)" : "0\(second4)"
        let minuteDoubleString4 = minute4 > 9 ? "\(minute4)" : "0\(minute4)"
        timeLabel4.text = ("\(minuteDoubleString4):\(secondDoubleString4).\(fragment4)")
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if chapter1.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash1(fileNamed: "Splash1Scene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                
            } else if chapter2.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash2(fileNamed: "Splash2Scene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                
            } else if chapter3.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash3(fileNamed: "Splash3Scene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                
            } else if chapter4.contains(pointOfTouch) {
                
                let sceneMoveTo = Splash4(fileNamed: "Splash4")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
                
            }
        }
    }
}
