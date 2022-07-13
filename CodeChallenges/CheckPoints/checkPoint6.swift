// Day 11 - Checkpoint 6 of https://www.hackingwithswift.com/100/swiftui
// 1. model and numSeats are private and constant
// 2. currentGear can be changed, and has a function to change gear from 1-10 only

enum GearDirection {
  case up, down
}

struct Car {
  private let model: String
  private let numSeats: Int
  var currentGear: Int = 1 {
    didSet {
      if currentGear < 1 {
        print("Current Gear is less than minimum: setting it to 1")
        currentGear = 1
      } else if currentGear > 10 {
        print("Current Gear is more than maximum: setting it to 10")
        currentGear = 10
      }
    }
  }

  init(_ m: String, _ n: Int) {
    self.model = m
    self.numSeats = n
  }
  
  mutating func changeGear(_ direction: GearDirection) {
    switch direction {
      case .up:
        currentGear += 1
        return
      case .down:
        currentGear -= 1
        return
    }
  }
}

// TESTS

var car = Car("MyCar", 1)

print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 1)
car.changeGear(GearDirection.up)
print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 2)
car.changeGear(GearDirection.up)
print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 3)
car.changeGear(GearDirection.up)
print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 4)
car.changeGear(GearDirection.up)
print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 5)
car.changeGear(GearDirection.down)
print(car)  // Car(model: "MyCar", numSeats: 1, currentGear: 4)
car.changeGear(GearDirection.down)
print(car)  // Car(model: "MyCar", numSeats: 1, currentGear: 3)
car.changeGear(GearDirection.down)
print(car)  // Car(model: "MyCar", numSeats: 1, currentGear: 2)
car.currentGear = 12 // Current Gear is more than maximum: setting it to 10
print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 10)
car.currentGear = -1 // Current Gear is less than minimum: setting it to 1
print(car) // Car(model: "MyCar", numSeats: 1, currentGear: 1)