//
//  Splash1.swift
//  Nano Challenge 3
//
//  Created by Michael Geoferey on 13/06/20.
//  Copyright © 2020 Michael Geoferey. All rights reserved.
//

import SpriteKit

class Splash1: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let skView = self.view as SKView?
        
        let sceneMoveTo = GameScene(fileNamed: "GameScene")
        sceneMoveTo?.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(withDuration: 1)
        skView?.presentScene(sceneMoveTo!, transition: sceneTransition)
        
    }
}
