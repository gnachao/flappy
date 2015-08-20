//
//  GameViewController.swift
//  Swiftly Bird
//
//  Created by Troy Do on 2/20/15.
//  Copyright (c) 2015 X Institute. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

  override func viewWillLayoutSubviews() {
  
    super.viewWillLayoutSubviews()
    
    if let skView = self.view as? SKView {
      if skView.scene == nil {
      
        // Create the scene
        let aspectRatio = skView.bounds.size.height / skView.bounds.size.width
        let scene = GameScene(size:CGSize(width: 320, height: 320 * aspectRatio))
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
      }
    }
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }

}
