//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLeftLabel: UILabel!
    @IBOutlet weak var timerLeftProgress: UIProgressView!
    @IBOutlet weak var softEggView: UIView!
    @IBOutlet weak var mediumEggView: UIView!
    @IBOutlet weak var hardEggView: UIView!
    let eggDurations = ["Soft": 1, "Medium": 7, "Hard": 12]
    var totalTime = 0
    let eggViewAlphaStart = 0.3
    let eggViewAlphaDefault = 1.0
    var timer: Timer?
    var player = AVAudioPlayer()
    var activeEgg: UIView? = nil
    
    
    func stopTimer() {
        timer?.invalidate()
    }

    func startTimer(duration: Int) {
        stopTimer()
        totalTime = duration
        timerLeftProgress.alpha = 1
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            if self.totalTime > 0 {
                self.totalTime -= 1
                let timerLeft = timeFormatted(totalSeconds: self.totalTime)
                timerLeftLabel.text = timerLeft
                let timerLeftPercentage = (Float(duration) - Float(self.totalTime)) / Float(duration)
                timerLeftProgress.progress = timerLeftPercentage
                activeEgg?.alpha = Float(timerLeftPercentage) - Float(eggViewAlphaStart) > 0 ? CGFloat(timerLeftPercentage) : eggViewAlphaStart
            } else {
                stopTimer()
                timerLeftLabel.text = "DONE!"
                timerLeftProgress.progress = 1
                playSound()
                activeEgg?.alpha = eggViewAlphaDefault
                activeEgg = nil
            }
        }
    }
    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    deinit {
        stopTimer()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    func setEggBlur() {
        softEggView.alpha = eggViewAlphaDefault
        mediumEggView.alpha = eggViewAlphaDefault
        hardEggView.alpha = eggViewAlphaDefault
        activeEgg?.alpha = eggViewAlphaStart
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!;
        let minutesDuration = eggDurations[hardness]!
        switch hardness {
        case "Soft":
            activeEgg = softEggView
            setEggBlur()
        case "Medium":
            activeEgg = mediumEggView
            setEggBlur()
        case "Hard":
            activeEgg = hardEggView
            setEggBlur()
        default:
            print("Error")
        }
        startTimer(duration: minutesDuration * 60)
    }
}
