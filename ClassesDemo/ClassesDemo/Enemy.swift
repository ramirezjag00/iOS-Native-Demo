
class Enemy {
    var health = 100
    var attackStrength = 10
    
    func move() {
        print("Walk fowards.")
    }
    
    func attack() {
        print("Land a hit, does \(attackStrength) damage.")
    }
}
