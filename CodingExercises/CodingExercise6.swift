//Don't change this
var aYear =  Int(readLine()!)! 

func isLeap(year: Int) {
  // print if a year is a leap year or not using if else conditions
  //Write your code inside this function.
  if (year.isMultiple(of: 4) && !year.isMultiple(of: 100)) || year.isMultiple(of: 400) {
      print("YES")
  } else {
      print("NO")
  }
}
