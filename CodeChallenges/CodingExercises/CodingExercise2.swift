func exercise() {
    // print an array of current number x to the next number y
    let numbers = [45, 73, 195, 53]
    
    //Write your code here
    let computedNumbers = numbers.enumerated().map { (index: Int, element: Int) -> Int in 
    let multiplier = (index == numbers.count - 1) ? numbers[0] : numbers[index + 1];
    return element * multiplier;
    }
    
    
    print(computedNumbers)

}

exercise()
