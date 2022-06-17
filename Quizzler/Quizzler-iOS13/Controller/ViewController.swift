//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var falseButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContent()
    }
    
    func clearButtons() {
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }
    
    func updateContent() {
        questionLabel.text = quizBrain.getLabel()
        progressBar.progress = quizBrain.getProgress()
        clearButtons()
    }
    
    func resetContent() {
        quizBrain.reset()
        trueButton.setTitle("True", for: .normal)
        falseButton.setTitle("False", for: .normal)
        updateContent()
    }
    
    func handleButtonHighlight(_ isCorrectAnswer: Bool, _ sender: UIButton) {
        if isCorrectAnswer {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
    }
    
    func handleQuestionTransition(_ isNotLastQuestion: Bool) {
        if isNotLastQuestion {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.updateContent()
            }
        } else {
            progressBar.progress = 1.0
            let scoreComment = quizBrain.getScoreComment()
            questionLabel.text = "\(quizBrain.getScore()) out of \(quizBrain.quiz.count), \(scoreComment), do you want to restart?"
            clearButtons()
            trueButton.setTitle(quizBrain.resetStates[0], for: .normal)
            falseButton.setTitle(quizBrain.resetStates[1], for: .normal)
        }
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let shouldReset = quizBrain.checkShouldReset(userAnswer)
        let shouldContinue = quizBrain.shouldContinue(userAnswer)

        if shouldReset {
            resetContent()
        } else if shouldContinue {
            let isCorrectAnswer = quizBrain.checkAnswer(userAnswer)
            let isNotLastQuestion = quizBrain.isNotLastQuestion()
            handleButtonHighlight(isCorrectAnswer, sender);
            handleQuestionTransition(isNotLastQuestion)
        }
    }
}

