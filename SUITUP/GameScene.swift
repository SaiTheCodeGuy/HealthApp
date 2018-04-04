//
//  GameScene.swift
//  Test
//
//  Created by Ronak Chaudhuri on 2/28/18.
//  Copyright © 2018 Ronak Chaudhuri. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {


    var egg = SKSpriteNode()
    var isJumping = false
    var isTouching = false
    var player = SKSpriteNode()
    var line = SKSpriteNode()
    var Bullet = SKSpriteNode()
    var cpu = SKSpriteNode()
    

    override func didMove(to view: SKView)
    {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        player = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 90, height: 90))
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: 0, y: -520)
        
        self.addChild(player)
        
        line = SKSpriteNode(color: UIColor.red, size: CGSize(width: 1000, height: 5))
        line.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        line.position = CGPoint(x: 0, y: -350)
        
        self.addChild(line)

        
        cpu = SKSpriteNode(color: UIColor.red, size: CGSize(width: 90, height: 90))
        cpu.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        cpu.position = CGPoint(x: 0, y: 520)

        self.addChild(cpu)
        
      

    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        shootingBullets()
        cpuBullet()
        //let randomNumber = Int(arc4random_uniform(750))
        let wait = SKAction.wait(forDuration: 1.0)
        //cpu.position = CGPoint(x: Int(randomNumber - 375), y: 520)
        var moveCpu = SKAction.moveTo(x:cpu.size.width - self.size.width, duration: 1)
        let cpuSequence = SKAction.sequence([moveCpu])
        let unlimited = 1
        
        
        if cpu.position == CGPoint(x: -375, y: 520)
        {

            var moveCpu = SKAction.moveTo(x:self.size.width - cpu.size.width, duration: 1)

        }
        else if cpu.position == CGPoint(x: 375, y: 520)
        {

            var moveCpu = SKAction.moveTo(x:cpu.size.width - self.size.width, duration: 1)
        }
          else if cpu.position == CGPoint(x: 0, y: 520)
            {

                var moveCpu = SKAction.moveTo(x:cpu.size.width - self.size.height, duration: 1)

                print("Hi")
            }
            cpu.run(cpuSequence)


        

            cpu.run(cpuSequence)

        
        
        
//            cpu.position = CGPoint(x: Int(randomNumber - 375), y: 520)
         //   cpu.run(SKAction.sequence([wait]))
       
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches
        {

            let location = touch.location(in: self)
            player.position.x = location.x
            player.position.y = location.y
            
            if player.position.y > -400
            {
                player.position.y = -400
            }
        }
       

    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {

    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        
    }


    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
   func shootingBullets()
    {
        var Bullet = SKSpriteNode(imageNamed: "Bullet")
        Bullet.setScale(0.3)
        Bullet.zPosition = -5
        Bullet.position = player.position
        self.addChild(Bullet)
        
        let moveBullet = SKAction.moveTo(y: self.size.height + Bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
        Bullet.run(bulletSequence)
        
    }
    func cpuBullet()
    {
        var cpuBullet = SKSpriteNode(imageNamed: "BulletDown")
        cpuBullet.setScale(0.3)
        
        cpuBullet.zPosition = -5
        cpuBullet.position = cpu.position
        self.addChild(cpuBullet)
        
        let cpuMoveBullet = SKAction.moveTo(y: cpuBullet.size.height - self.size.height, duration: 1)
        let cpuDeleteBullet = SKAction.removeFromParent()
        let cpuBulletSequence = SKAction.sequence([cpuMoveBullet, cpuDeleteBullet])
        cpuBullet.run(cpuBulletSequence)
    }

        
    }



