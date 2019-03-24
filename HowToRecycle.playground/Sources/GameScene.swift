
import PlaygroundSupport
import SpriteKit
import GameKit

public class GameScene: SKScene, SKPhysicsContactDelegate{
    
    private var currentNode: SKNode?
    var greenTrash = SKSpriteNode()
    var blueTrash = SKSpriteNode()
    var yellowTrash = SKSpriteNode()
    var redTrash = SKSpriteNode()
    var background = SKSpriteNode()
    var scoreLabel: SKLabelNode!
    var difficulty = 5.0
    public var isDifficulty = true
    var score = 0 {
        didSet {
            scoreLabel.text = "Score : \(score)"
        }
    }

    var allWastePath = ["bagPlastic.png", "bookPaper.png", "boxPaper.png", "cheeseOrganic.png", "glassBottle2.png", "diskPlastic.png", "fishOrganic.png", "glass.png", "glassBottle.png", "newsPaper.png", "bottlePlastic.png", "tomatoOrganic.png"]
    var allWaste: Array<SKSpriteNode> = Array()
    
     public override func didMove(to view: SKView) {
        
        greenTrash = self.childNode(withName: "greenTrash") as! SKSpriteNode
        blueTrash = self.childNode(withName: "blueTrash") as! SKSpriteNode
        yellowTrash = self.childNode(withName: "yellowTrash") as! SKSpriteNode
        redTrash = self.childNode(withName: "redTrash") as! SKSpriteNode

        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 30
        scoreLabel.text = "Score: 0"
        scoreLabel.fontColor = .black
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -200, y: 390)
        addChild(scoreLabel)
        
        physicsWorld.contactDelegate = self

        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(spawnWaste),
                SKAction.wait(forDuration: difficulty)
                ])
        ))
    }
//
//    @objc static override var supportsSecureCoding: Bool {
//        // SKNode conforms to NSSecureCoding, so any subclass going
//        // through the decoding process must support secure coding
//        get {
//            return true
//        }
//    }
    func spawnWaste() {
        let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: allWastePath.count)
        let waste = SKSpriteNode()
        
        waste.texture = SKTexture(imageNamed: allWastePath[randomIndex])
        waste.name = "Waste : " + allWastePath[randomIndex]
        waste.size = CGSize(width: (waste.texture?.size().width)! / 1.5, height: (waste.texture?.size().height)! / 1.5)
        let positionX = CGFloat.random(in: (self.frame.minX + waste.size.width)...(self.frame.maxX - waste.size.width))
        waste.position = CGPoint(x: positionX, y: self.frame.maxY + 100)
        waste.physicsBody = SKPhysicsBody(texture: waste.texture!, size: waste.size)
        waste.physicsBody?.contactTestBitMask = waste.physicsBody?.collisionBitMask ?? 0
        addChild(waste)
        allWaste.append(waste)
        waste.physicsBody?.isDynamic = true
        if self.isDifficulty == true {
            difficulty += 0.05
        }
    }
    
    func destroy(waste: SKNode) {
        waste.removeFromParent()
    }
    
    func collision(between waste: SKNode, trash: SKNode) {
        switch trash.name! {
        case "blueTrash":
            if waste.name!.contains("glass") {
                destroy(waste: waste)
                score += 10
            } else {
                destroy(waste: waste)
                score -= 5
            }
            break
        case "yellowTrash":
            if waste.name!.contains("Paper") {
                destroy(waste: waste)
                score += 10
            } else {
                destroy(waste: waste)
                score -= 5
            }
            break
        case "greenTrash":
            if waste.name!.contains("Organic") {
                destroy(waste: waste)
                score += 10
            } else {
                destroy(waste: waste)
                score -= 5
            }
            break
        case "redTrash":
            if waste.name!.contains("Plastic") {
                destroy(waste: waste)
                score += 10
            } else {
                destroy(waste: waste)
                score -= 5
            }
            break
        default:
            break
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name!.contains("Trash") == true {
            collision(between: contact.bodyB.node!, trash: contact.bodyA.node!)
        } else if contact.bodyB.node?.name!.contains("Trash")  == true {
            collision(between: contact.bodyA.node!, trash: contact.bodyB.node!)
        }
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if allWaste.contains(node as! SKSpriteNode) {
                    self.currentNode = node
                    self.currentNode?.physicsBody?.isDynamic = false
                }
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode?.physicsBody?.isDynamic = true
        self.currentNode = nil
        
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode?.physicsBody?.isDynamic = true
        self.currentNode = nil
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        self.scoreLabel?.text = "Score : \(score)"
    }
}

