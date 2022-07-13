// Day 12 - Checkpoint 7 of https://www.hackingwithswift.com/100/swiftui

class Animal {
    var legs: Int
    
    init(legs l: Int = 4) {
        self.legs = l
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(isTame isT: Bool) {
        self.isTame = isT
        super.init(legs: 4)
    }

    func speak() {
        print("Meow meow meow!!!")
    }
}

class Persian: Cat {
    override init(isTame isT: Bool) {
        super.init(isTame: isT)
    }

    override func speak() {
        super.speak()
        print("Persian meow!")
    }
}

class Lion: Cat {
    override init(isTame isT: Bool) {
        super.init(isTame: isT)
    }

    override func speak() {
        super.speak()
        print("Lion meow!")
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }

    func speak() {
        print("Arf arf arf!!!")
    }
}

class Corgi: Dog {
    override func speak() {
        super.speak()
        print("Corgi bark bark!")
    }
}

class Poodle: Dog {
    override func speak() {
        super.speak()
        print("Pooodle bark bark!")
    }
}

// TESTS
// make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
// But there’s more:
//
// The Animal class should have a legs integer property that tracks how many legs the animal has.
// The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
// The Cat class should have a matching speak() method, again with each subclass printing something different.
// The Cat class should have an isTame Boolean property, provided using an initializer.

let animal = Animal()
print(animal.legs)

let cat = Cat(isTame: true)
print(cat.legs)
cat.speak()

let persian = Persian(isTame: true)
print(persian.legs)
print(persian.isTame)
persian.speak()

let lion = Lion(isTame: false)
print(lion.legs)
print(lion.isTame)
lion.speak()

let dog = Dog()
print(dog.legs)
dog.speak()

let corgi = Corgi()
print(corgi.legs)
corgi.speak()

let poodle = Poodle()
print(poodle.legs)
poodle.speak()
