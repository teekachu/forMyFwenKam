//
//  GameScene.swift
//  Target Practice
//
//  Created by meekam okeke on 11/24/20.
//

import SpriteKit

class GameScene: SKScene {
    var charNode: SKSpriteNode!
    var snowField: SKEmitterNode!
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var bulletsLabel: SKLabelNode!
    var gameTimer: Timer?
    var targetTimer: Timer?
    
    var isGameOver: Bool = false
    var isHit: Bool = false
    
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var bulletsLeft = 6{
        didSet{
            bulletsLabel.text = "Bullets Left: \(bulletsLeft)"
        }
    }
    
    var secondsRemaining = 60
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        backgroundColor = .black
        snowField = SKEmitterNode(fileNamed: "snowField")
        snowField.position = CGPoint(x: 1024, y: 384)
        snowField.advanceSimulationTime(10)
        snowField.zPosition = -1
        addChild(snowField)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 6, y: 6)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        score = 0
        
        timerLabel = SKLabelNode(fontNamed: "Chalkduster")
        timerLabel.position = CGPoint(x: 1000, y: 740)
        timerLabel.horizontalAlignmentMode = .right
        addChild(timerLabel)
        
        bulletsLabel = SKLabelNode(fontNamed: "Chalkduster")
        bulletsLabel.position = CGPoint(x: 6, y: 735)
        bulletsLabel.horizontalAlignmentMode = .left
        addChild(bulletsLabel)
        bulletsLeft = 6
        
        physicsWorld.gravity = .zero
        
        /// you are already calling this using the targetTimer. no need to do it again
        //                createTarget()
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        targetTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes{
            if node.name == "charFriend"{
                score -= 3
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
            }else if node.name == "charEnemy"{
                score += 5
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }else{
                score -= 1
            }
        }
        hit()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc func countDown(){
        secondsRemaining -= 1
        timerLabel.text = "Timer: \(secondsRemaining)"
        
        if secondsRemaining == 0 {
            let GameOver = SKSpriteNode(imageNamed: "gameOver")
            GameOver.position = CGPoint(x: 512, y: 384)
            GameOver.zPosition = 1
            addChild(GameOver)
            run(SKAction.playSoundFileNamed("gameOver.m4a", waitForCompletion: false))
            gameTimer?.invalidate()
        }
    }
    
    ///MARK: TODO CHANGE
    @objc func createTarget(){
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        /// in line 11, you decleared charnode as a SKSpritenode. There fore you have to initialize this SKSpritenode before you could update its texture.
        charNode.texture = SKTexture(imageNamed: "penguinGood")
        charNode.physicsBody = SKPhysicsBody(texture: charNode.texture!, size: charNode.size)
        charNode.name = "charFriend"
        charNode.physicsBody?.linearDamping = 0
        charNode.physicsBody?.angularDamping = 0
        charNode.physicsBody?.categoryBitMask = 1
        charNode.position = CGPoint(x: 0, y: Int.random(in: 70...500))
        /// addchild here. Since on the bottom we are just changing the image texture we dont need to call addchild again.
        addChild(charNode)
        
        charNode.texture = SKTexture(imageNamed: "penguinEvil")
        charNode.position = CGPoint(x: -100, y: Int.random(in: 50...700))
        charNode.name = "charEnemy"
        charNode.physicsBody = SKPhysicsBody(texture: charNode.texture!, size: charNode.size)
        charNode.physicsBody?.linearDamping = 0
        charNode.physicsBody?.categoryBitMask = 1
        charNode.physicsBody?.angularDamping = 0
        
        if Int.random(in: 0...3) == 0{
            //small and fast target
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.xScale = CGFloat(0.8)
            charNode.yScale = charNode.xScale
            charNode.physicsBody?.velocity = CGVector(dx: Int.random(in: 450...500), dy: 0)
        }else if Int.random(in: 0...3) == 1{
            //small and fasr target
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.xScale = CGFloat(0.95)
            charNode.yScale = charNode.xScale
            charNode.physicsBody?.velocity = CGVector(dx: Int.random(in: 350...450), dy: 0)
        }else if Int.random(in: 0...3) == 2{
            //big and slow target
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.xScale = CGFloat(1.5)
            charNode.yScale = charNode.xScale
            charNode.physicsBody?.velocity = CGVector(dx: Int.random(in: 150...200), dy: 0)
        }else if Int.random(in: 0...3) == 3{
            //big and slow target
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.xScale = CGFloat(2.0)
            charNode.yScale = charNode.xScale
            charNode.physicsBody?.velocity = CGVector(dx: Int.random(in: 100...150), dy: 0)
        }
        
    }
    func hit(){
        isHit = true
        let explosion = SKEmitterNode(fileNamed: "explosion")
        explosion?.position = charNode.position
        addChild(explosion!)
        charNode.removeFromParent()
    }
}
