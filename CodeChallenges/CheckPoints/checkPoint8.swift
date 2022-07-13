// Day 13 - Checkpoint 8 of https://www.hackingwithswift.com/100/swiftui

// make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:

// A property storing how many rooms it has.
// A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
// A property storing the name of the estate agent responsible for selling the building.
// A method for printing the sales summary of the building, describing what it is along with its other properties.

import Foundation

protocol BuildingDelegate {
  var rooms: Int { get }
  var cost: Int { get set }
  var agent: String { get set }
  func salesSummary()
}

extension Int {
  func withCommas() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return "$\(numberFormatter.string(from: NSNumber(value:self))!)"
  }
}

extension BuildingDelegate {
  func salesSummary() {
    print("The building has \(rooms) rooms, amounting to \(cost.withCommas()) and is handled by agent \(agent)")
  }
}

struct House: BuildingDelegate {
  let rooms: Int
  var cost: Int
  var agent: String
}

struct Office: BuildingDelegate {
  let rooms: Int
  var cost: Int
  var agent: String
}

// TESTS

var house = House(rooms: 10, cost: 10_231, agent: "FooBar")
var office = Office(rooms: 100, cost: 100_312_312, agent: "FizzBuzz")

house.salesSummary() // The building has 10 rooms, amounting to $10,231 and is handled by agent FooBar
house.cost = 10_500
house.agent = "John Doe"
house.salesSummary() // The building has 10 rooms, amounting to $10,500 and is handled by agent John Doe

office.salesSummary() // The building has 100 rooms, amounting to $100,312,312 and is handled by agent FizzBuzz
office.cost = 100_500_200
office.agent = "Jane Doe"
office.salesSummary() // The building has 100 rooms, amounting to $100,500,200 and is handled by agent Jane Doe