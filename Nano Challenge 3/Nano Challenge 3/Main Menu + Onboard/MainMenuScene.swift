//
//  mainmenuVC.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 11/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var pressContinue = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        pressStart = self.childNode(withName: "PressContinue") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if p.contains(pointOfTouch) {
                
                let sceneMoveTo = GameScene(fileNamed: "GameScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
            }
        }
    }
    
    
}
