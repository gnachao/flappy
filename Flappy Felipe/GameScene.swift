//
//  GameScene.swift
//  Swiftly Bird
//
//Created by Troy Do on 2/20/15.
//Copyright (c) 2015 X Institute. All rights reserved.
//

import SpriteKit

enum Layer: CGFloat {
  case Background
  case Foreground
  case Player
}

class GameScene: SKScene {

  let kGravity: CGFloat = -1500.0
  let kImpulse: CGFloat = 400.0

  let worldNode = SKNode()
  var playableStart: CGFloat = 0
  var playableHeight: CGFloat = 0
    
  let player = SKSpriteNode(imageNamed: "Bird")
  var lastUpdateTime: NSTimeInterval = 0
  var dt: NSTimeInterval = 0
  var playerVelocity = CGPoint.zeroPoint

  override func didMoveToView(view: SKView) {
    addChild(worldNode)
    setupBackground()
    setupForeground()
    setupPlayer()
  }
  
  // MARK: Setup methods
  
  func setupBackground() {
    
    let background = SKSpriteNode(imageNamed: "Background")
    background.anchorPoint = CGPoint(x: 0.5, y: 1.0)
    background.position = CGPoint(x: size.width/2, y: size.height)
    background.zPosition = Layer.Background.rawValue
    worldNode.addChild(background)
    
    playableStart = size.height - background.size.height
    playableHeight = background.size.height
  
  }
  
  func setupForeground() {
  
    let foreground = SKSpriteNode(imageNamed: "Ground")
    foreground.anchorPoint = CGPoint(x: 0, y: 1)
    foreground.position = CGPoint(x: 0, y: playableStart)
    foreground.zPosition = Layer.Foreground.rawValue
    worldNode.addChild(foreground)
  
  }
  
  func setupPlayer() {
  
    player.position = CGPoint(x: size.width * 0.2, y: playableHeight * 0.4 + playableStart)
    player.zPosition = Layer.Player.rawValue
    worldNode.addChild(player)
  
  }
  
  // MARK: Gameplay
  
  func flapPlayer() {
    playerVelocity = CGPoint(x: 0, y: kImpulse)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    flapPlayer()
  }
  
  // MARK: Updates
  
  override func update(currentTime: CFTimeInterval) {
    if lastUpdateTime > 0 {
      dt = currentTime - lastUpdateTime
    } else {
      dt = 0
    }
    lastUpdateTime = currentTime
    
    updatePlayer()
  }
  
  func updatePlayer() {
  
    // Apply gravity
    let gravity = CGPoint(x: 0, y: kGravity)
    let gravityStep = gravity * CGFloat(dt)
    playerVelocity += gravityStep
    
    // Apply velocity
    let velocityStep = playerVelocity * CGFloat(dt)
    player.position += velocityStep
    
    // Temporary halt when hits ground
    if player.position.y - player.size.height/2 < playableStart {
      player.position = CGPoint(x: player.position.x, y: playableStart + player.size.height/2)
    }
  
  }
  
}
