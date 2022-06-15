//Don't change this
var aYear =  Int(readLine()!)! 

func isLeap(year: Int) {
  
  //Write your code inside this function.
  if (year.isMultiple(of: 4) && !year.isMultiple(of: 100)) || year.isMultiple(of: 400) {
      print("YES")
  } else {
      print("NO")
  }
}
