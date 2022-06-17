//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Andrey Ramirez on 6/18/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    let scoreComments = ["teach me, senpai!", "almost there!", "not bad...", "barely made it", "better luck next time", "brain not found"]
    let resetStates = ["YES", "NO"]
    var questionNumber = 0
    var score = 0

    let quiz = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
        
    ]
    
    func checkShouldReset(_ userAnswer: String) -> Bool {
        return userAnswer == resetStates[0]
    }
    
    func shouldContinue(_ userAnswer: String) -> Bool {
        return userAnswer != resetStates[1]
    }
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        let rightAnswer = quiz[questionNumber].answer
        let isCorrectAnswer = rightAnswer == userAnswer
        if (isCorrectAnswer) {
            score += 1
        }
     
        return isCorrectAnswer
    }
    
    mutating func isNotLastQuestion() -> Bool {
        let isNotLastQuestion = quiz.count > questionNumber + 1
        if isNotLastQuestion {
            questionNumber += 1
        }
        return isNotLastQuestion
    }
    
    func getLabel() -> String {
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    func getScoreComment() -> String {
        switch score {
        case 11...12:
            return scoreComments[0]
        case 9...10:
            return scoreComments[1]
        case 7...8:
            return scoreComments[2]
        case 5...6:
            return scoreComments[3]
        case 3...4:
            return scoreComments[4]
        case 0...2:
            return scoreComments[5]
        default:
            return "Error"
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func reset () {
        questionNumber = 0
        score = 0
    }

}
