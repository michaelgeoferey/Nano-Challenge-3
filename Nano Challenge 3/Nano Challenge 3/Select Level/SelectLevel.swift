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
    var chapterSoon = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        chapter1 = self.childNode(withName: "Chapter1") as! SKSpriteNode
        chapter2 = self.childNode(withName: "Chapter2") as! SKSpriteNode
        chapter3 = self.childNode(withName: "Chapter3") as! SKSpriteNode
        chapter4 = self.childNode(withName: "Chapter4") as! SKSpriteNode
        chapterSoon = self.childNode(withName: "ChapterSoon") as! SKSpriteNode
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
