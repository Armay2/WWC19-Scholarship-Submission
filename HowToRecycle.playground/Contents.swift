import PlaygroundSupport
import SpriteKit
import Foundation

//: # How to Recycle
//: ### The aim of this game is to make children learn how to recycle they wastes.

//:There are 4 different bins that look like this:
//: *  *  *  *  *
//:  ![](dustbin.png)
//:  *  *  *  *  *

/*:
 And different __items__ are falling from the top of the screen. You just have to catch them and put them into the right bin.
 The Red one is for Plastic Wastes, the yellow is for paper, the green for organic and the blue for glass. Now you know all about this game, __So let's play !!__
*/
/*:
 - Note:
 "The difficulty increases over time"
 
 */

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 632, height: 891))
if let scene = GameScene(fileNamed: "GameScene") {
scene.scaleMode = .aspectFill

scene.isDifficulty = true
    
// Present the scene
sceneView.presentScene(scene)
}
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

