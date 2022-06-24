// inherits Enemy SuperClass
// Dragon SubClass of Enemy SuperClass
class Dragon: Enemy {
    var wingSpan = 2
    
    func talk(speech: String) {
        print("Says: \(speech)")
    }
    
    // overrides move method of Class Enemy
    override func move() {
        print("Flies up!")
    }
    
    override func attack() {
        // refers to Enemy Class attack method
        super.attack()
        // then does its own thing after
        print("Spit fire, does 10 damage. ")
    }
}
