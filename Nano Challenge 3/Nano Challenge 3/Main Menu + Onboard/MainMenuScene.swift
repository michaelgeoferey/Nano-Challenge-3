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
    let backgroundMusic = SKAudioNode(fileNamed: "onboardBGM.wav")
    
    override func didMove(to view: SKView) {
        pressContinue = self.childNode(withName: "PressContinue") as! SKSpriteNode
        self.addChild(backgroundMusic)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches{
            let pointOfTouch = touch.location(in: self)
            let skView = self.view as SKView?
            
            if pressContinue.contains(pointOfTouch) {
                
                let sceneMoveTo = Onboard(fileNamed: "OnboardScene")
                sceneMoveTo?.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fade(withDuration: 1)
                skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
            }
        }
    }
    
    
}
