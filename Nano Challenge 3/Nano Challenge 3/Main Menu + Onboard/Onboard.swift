//
//  Onboard.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 12/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit

class Onboard: SKScene{

    var pressStart = SKSpriteNode()
    let backgroundMusic = SKAudioNode(fileNamed: "onboardBGM.wav")
    
    override func didMove(to view: SKView) {
        pressStart = self.childNode(withName: "PressStart") as! SKSpriteNode
//        self.addChild(backgroundMusic)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           
           for touch: AnyObject in touches{
               let pointOfTouch = touch.location(in: self)
               let skView = self.view as SKView?
               
               if pressStart.contains(pointOfTouch) {
                   
                   let sceneMoveTo = Splash1(fileNamed: "Splash1Scene")
                   sceneMoveTo?.scaleMode = self.scaleMode
                   let sceneTransition = SKTransition.fade(withDuration: 1)
                   skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
               }
           }
       }

}
