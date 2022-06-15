//Don't change this
var studentsAndScores = ["Amy": Int(readLine()!)!, "James": Int(readLine()!)!, "Helen": Int(readLine()!)!]

func highestScore(scores: [String: Int]) {
  
  //Write your code here.
  let sortedScores = scores.sorted(by: { $1.value < $0.value })
  print(sortedScores.first!.value)
}
