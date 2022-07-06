func exercise() {
    // print a 6 character long password from the alphabet array
    
    let alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    //The number of letters in alphabet equals 26
    //Write your code here.
    let password = ((0..<6).map{_ in return alphabet[Int.random(in: 0...alphabet.count - 1)]}).joined(separator: "") 
    
    print(password)
    
    
}

exercise()
