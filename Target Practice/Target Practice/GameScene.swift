//
//  GameScene.swift
//  Target Practice
//
//  Created by meekam okeke on 11/24/20.
//

import SpriteKit

class GameScene: SKScene {
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
        createTarget()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        targetTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
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
    @objc func createTarget(){
        
        let goodTarget = SKSpriteNode(imageNamed: "penguinGood")
        goodTarget.physicsBody = SKPhysicsBody(texture: goodTarget.texture!, size: goodTarget.size)
        goodTarget.physicsBody?.linearDamping = 0
        goodTarget.physicsBody?.angularDamping = 0
        goodTarget.physicsBody?.categoryBitMask = 1
        goodTarget.position = CGPoint(x: 0, y: Int.random(in: 60...550))

        let badTarget = SKSpriteNode(imageNamed: "penguinEvil")
        badTarget.physicsBody = SKPhysicsBody(texture: badTarget.texture!, size: badTarget.size)
        badTarget.physicsBody?.categoryBitMask = 1
        badTarget.physicsBody?.linearDamping = 0
        badTarget.physicsBody?.angularDamping = 0
        badTarget.position = CGPoint(x: 0, y: Int.random(in: 50...600))
        
        
        let num = Int.random(in: 0 ... 3)
        
        if num == 0{
            /// small and fast
            addChild(goodTarget)
            goodTarget.xScale = CGFloat(0.7)
            goodTarget.yScale = goodTarget.xScale
            goodTarget.physicsBody?.velocity = CGVector(dx: Int.random(in: 500 ... 600), dy: 0)
            
        } else if num == 1{
            /// small and fast
            addChild(badTarget)
            badTarget.xScale = CGFloat(0.9)
            badTarget.yScale = badTarget.xScale
            badTarget.physicsBody?.velocity = CGVector(dx: Int.random(in: 450 ... 550), dy: 0)
            
        } else if num == 2{
            /// mid and medium speed
            addChild(goodTarget)
            goodTarget.xScale = CGFloat(1)
            goodTarget.yScale = goodTarget.xScale
            goodTarget.physicsBody?.velocity = CGVector(dx: Int.random(in: 250 ... 450), dy: 0)

        } else if num == 3{
            /// large and slow
            addChild(badTarget)
            badTarget.xScale = CGFloat(1.5)
            badTarget.yScale = badTarget.xScale
            badTarget.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
            
        }
        
    }
    
    func hit(){
        isHit = true
        let explosion = SKEmitterNode(fileNamed: "explosion")
        
    }
}
