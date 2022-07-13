// Day 9 - Checkpoint 5 of https://www.hackingwithswift.com/100/swiftui

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

// print odd numbers in ascending order with concatinated string "X is a lucky nuumber" after chaining filter, sorted and map in closure syntaxes
var foo: [Int] = luckyNumbers
            .filter({ $0 % 2 != 0 })
            .sorted(by: <)
            .map { print("\($0) is a lucky number"); return $0 }
