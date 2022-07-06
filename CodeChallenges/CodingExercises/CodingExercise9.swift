//Don't change this
var studentsAndScores = ["Amy": Int(readLine()!)!, "James": Int(readLine()!)!, "Helen": Int(readLine()!)!]

func highestScore(scores: [String: Int]) {
  // print the highest score from a dictionary if scores
  
  //Write your code here.
  let sortedScores = scores.sorted(by: { $1.value < $0.value })
  print(sortedScores.first!.value)
}
