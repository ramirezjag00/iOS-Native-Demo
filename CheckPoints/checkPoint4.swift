// Day 8 - Checkpoint 4 of https://www.hackingwithswift.com/100/swiftui

enum numberError: Error {
  case outOfBounds, noRoot
}

func sqroot(_ number: Int) throws -> Int {
  if (number < 1 || number > 10_000) {
    throw numberError.outOfBounds    
  }
  
  for i in 1...100 {
    if i * i == number {
      return i
    }
  }

  throw numberError.noRoot
}

let integer = 10_000
// uncomment data samples
// let integer = 102
// let integer = -5
// let integer = 10_500

do {
  let root = try sqroot(integer)
  print("Squareroot of \(integer) is \(root)")
} catch numberError.outOfBounds {
  print("Out of bounds: \(integer)")
} catch numberError.noRoot {
  print("No Root: \(integer)")
}