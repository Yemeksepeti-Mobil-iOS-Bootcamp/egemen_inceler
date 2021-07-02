import Foundation

struct Gun{
    /*
     0 < teta < 90
     0 < v < 100
     topatar 0 noktasında sabit
     */
    var g = 10.0
    var angle: Double
    var speed: Double
    
    init(teta: Double, v: Double){
        self.angle = teta
        self.speed = v
    }
    
    func range() -> Double{
        return self.speed*self.speed*sin(2*self.angle * Double.pi / 180)/g
    }
    
    func toString(){
        print("Angle: \(angle), speed: \(speed)")
    }
}

struct Bottle{
    /*
     0 < d < 1500
     0.1 < delta < 1
     */
    var distance: Double
    var delta: Double
    var durum: Bool
    
    init(distance: Double, delta: Double = 10.0, durum: Bool = true) {
        self.distance = distance
        self.delta = delta
        self.durum = durum
    }
    
    func bottleMaxDistanceArray() -> [Double]{
        return [distance-delta, distance+delta]
    }
    
    func toString(){
        print("Bottle distance: \(distance), delta: \(delta), durum: \(durum)")
    }
}

struct Player{
    var nickname: String
    var score: Int
    
    func toString(){
        print("Kullanıcı adı: \(nickname)")
        print("Puan: \(score)")
    }
}

struct Game{
    var player: Player
    var gun: Gun
    var bottle: Bottle
    
    
    init(player: Player = Player(nickname: "", score: -1),
         gun: Gun = Gun(teta: 0, v: 0),
         bottle: Bottle = Bottle(distance: 0)) {
        self.player = player
        self.gun = gun
        self.bottle = bottle
    }
    
    
    
    mutating func configurePlayer(){
        print("Kullanıcı adı giriniz: ")
        guard let name = readLine() else { return }
        self.player = Player(nickname: name, score: 0)
        
    }
    
    mutating func configureBottle(){
        print("Uzaklik giriniz: ")
        let distance = readLine()
        guard let d = Double(distance!) else {
            print("Geçerli bir sayı giriniz...")
            exit(0)
        }
        if (0 < d) && (d < 1500){
            
            print("Delta degeri giriniz: ")
            let delta = readLine()
            if let delta = Double(delta!)  {
                self.bottle = Bottle(distance: d, delta: delta, durum: true)
            }else{
                print("Delta degeri 0.1 < delta < 1 olmalıdır.")
                exit(0)
            }
        }else{
            print("d uzaklığı 0 < d < 1500 olmalıdır.")
            exit(0)
        }
    }
    
    mutating func configureTopatar(){
        print("Fırlatma açısını giriniz")
        let angle = readLine()
        guard let teta = Double(angle!) else {
            print("Geçerli bir sayi giriniz...")
            exit(0)
        }
        
        print("Hız giriniz")
        let v = readLine()
        guard let speed = Double(v!) else {
            print("Geçerli bir sayı giriniz...")
            exit(0)
        }
        
        if (0 < teta && teta < 90) && (0 < speed && speed < 1500) {
            self.gun = Gun(teta: teta, v: speed)
        }else{
            print("0 < teta < 90 ve 0 < v < 1500 olmalıdır.")
            exit(0)
        }
        
    }
    
    mutating func shot(){
        let range = self.gun.range()
        
        if self.bottle.bottleMaxDistanceArray().first! < range
            && range < self.bottle.bottleMaxDistanceArray().last!{
            self.bottle.durum = false
            self.player.score += 1
            print("Hit!")
        }
        else{
            print("Miss...")
        }
    }
    
    func showStats() {
        player.toString()
        gun.toString()
        bottle.toString()
    }
}

func startGame(){
    var game = Game()
    
    game.configurePlayer()
    game.configureTopatar()
    game.configureBottle()
    
    game.shot()
    print("------------------------------------------")
    game.showStats()
    
}

startGame()


