// Day 14 - Checkpoint 9 of https://www.hackingwithswift.com/100/swiftui

// write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.

// solution#1:  nil coalescing
func getRandomNumber(nums: [Int]?) -> Int {
    return nums?.randomElement() ?? Int.random(in: 1...100)
}

// solution#2: multiple optional binding and boolean condition
// func getRandomNumber (nums: [Int]?) -> Int {
//   if let numbers = nums, let len = nums?.count, len > 0 {
//     return numbers[Int.random(in: 0...len - 1)]
//   } else {
//     return Int.random(in: 1...100)
//   }
// }

// TESTS
print(getRandomNumber(nums: [1,2,3,4]))
print(getRandomNumber(nums: nil))
print(getRandomNumber(nums: []))