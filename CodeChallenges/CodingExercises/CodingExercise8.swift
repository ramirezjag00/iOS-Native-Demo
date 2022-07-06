func exercise() {
    // add and update key values in a dictionary
    //Don't change this
    var stockTickers: [String: String] = [
        "APPL" : "Apple Inc", 
        "HOG": "Harley-Davidson Inc", 
        "BOOM": "Dynamic Materials", 
        "HEINY": "Heineken", 
        "BEN": "Franklin Resources Inc"
    ]
    
    //Write your code here.
    stockTickers["WORK"] = "Slack Technologies Inc"
    stockTickers["BOOM"] = "DMC Global Inc"


  
     //Don't modify this
    print(stockTickers["WORK"]!)
    print(stockTickers["BOOM"]!)
}
