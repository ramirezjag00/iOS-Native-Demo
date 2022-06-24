
print("Hello")

// initiate a class Enemy
let skeleton = Enemy()

// check property of a class
print(skeleton.health)

// classes can call methods
skeleton.move()
skeleton.attack()

// can create multiple instances
let skeleton2 = Enemy()
let skeleton3 = Enemy()

// initiate Dragon Class
let dragon = Dragon()

// Dragon class inherits properties and methods of Enemy Class
dragon.move()
dragon.attack()

// it can also change the property values
dragon.wingSpan = 5
dragon.health = 200

// and have its own methods
dragon.talk(speech: "BWAAAAAAAAAAAAAUUUUHHHH")
