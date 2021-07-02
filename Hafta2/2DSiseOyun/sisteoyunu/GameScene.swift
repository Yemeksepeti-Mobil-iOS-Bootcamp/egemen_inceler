import SpriteKit
import GameplayKit


/*
 Aklımdaki her şeyi yapamadım fakat ortaya basit bir şey çıktı.
Eklenmesi gerekenler:
    1. UI Design.
    2. Tüm ekranlara uyumluluk :).
    3. Ekran boyutuna göre range hesabı. Tam olarak normalizasyon yapmadım. Bu yüzden şişe deltası 100.
    4. Basılı olduğunda bir bar yapmak istiyordum fakat bir sorunla karşılaştım tüm zamanımı yedi :).
    5. Basılı tutulduğunda açıyı gösteren gösterge eklemek.
 */

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "gun")
    var bottle = SKSpriteNode(imageNamed: "bottle")
    let ground = SKSpriteNode(imageNamed: "ground")
    let scoreTexture = SKLabelNode(fontNamed: "Chalkduster")
    let alert  = SKLabelNode()
    
    let delta = 100
    
    var startTime: Double?
    var endTime: Double?
    var score = 0
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white
        configureUI()
        
    }
    func configureUI(){
        player.position = CGPoint(x: -size.width/2  + 50, y: 0)
        player.size     = CGSize(width: 40, height: 40)
        
        bottle.position = CGPoint(x:  size.width/2  - 100, y: 0)
        bottle.size = CGSize(width: 40, height: 60)
        
        ground.position = CGPoint(x: 0, y: 0)
        ground.size     = CGSize(width: size.height/1.5, height: size.width/1.5)
        
        scoreTexture.fontColor = .black
        scoreTexture.position = CGPoint(x: 0, y: 200)
        scoreTexture.fontSize = 30
        
        alert.fontColor = .black
        alert.position = CGPoint(x: 0, y: 0)
        alert.fontSize = 30
        
        addChild(player)
        addChild(bottle)
        addChild(ground)
        addChild(scoreTexture)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endTime = Date.timeIntervalSinceReferenceDate

        let totalTime = endTime! - startTime!
        guard let pos = touches.first?.location(in: self) else { return }
        
        let tetaValue = findTeta(x1: Double(player.position.x), x2: Double(pos.x), y1: Double(player.position.y), y2: Double(pos.y))
        let teta = asin(tetaValue) * 180 / Double.pi
        var range = 0.0
        if totalTime > 6 {
            alert.text = "Çok Hızlı"
            addChild(alert)
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
                guard let self = self else { return }
                self.alert.text = ""
            }
            
        }else {
            range = findRange(v: totalTime*15, angle: teta, g: 10.0)
        }
        
        let gidecegiNokta = self.player.position.x + CGFloat(range)
        let minMax = [self.bottle.position.x - CGFloat(delta), self.bottle.position.x + CGFloat(delta)]
        if gidecegiNokta < minMax.last! && minMax.first! < gidecegiNokta {
            bottle.yScale = -1.0
            score += 1
            rotate(.pi, 0.2)
        }
    
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = CGPoint(x: -size.width/2  + 50, y: 0)
        bullet.size = CGSize(width: 30, height: 30)
        
        
        bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 30))
        bullet.physicsBody?.isDynamic = true
        
        
        addChild(bullet)
        bullet.physicsBody?.affectedByGravity = true
        
        let angle = teta/2
        bullet.physicsBody?.applyImpulse(CGVector(dx: range/10, dy:angle))
        
    }
    
    
    func rotate(_ angle: CGFloat, _ duration: Double){
        let rotate1 = SKAction.rotate(byAngle: angle, duration: duration)
        bottle.run(rotate1)
    }
    
    func findTeta(x1: Double, x2: Double, y1: Double, y2: Double) -> Double{
        return abs(y1-y2)/abs(x1-x2)
    }
    
    func findRange(v: Double, angle: Double, g: Double) -> Double{
        return v*v*sin(2*angle * Double.pi / 180)/g
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startTime = Date.timeIntervalSinceReferenceDate
    }
    
    override func update(_ currentTime: TimeInterval) {
        scoreTexture.text = "Score: \(score)"
    }
}

func +(left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x + right.x, y: left.y + right.y) }

func -(left: CGPoint, right: CGPoint) -> CGPoint { return CGPoint(x: left.x - right.x, y: left.y - right.y) }

func *(point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x * scalar, y: point.y * scalar) }

func /(point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x / scalar, y: point.y / scalar) }

