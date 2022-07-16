//
//  Score.swift
//  GuessTheFlag
//
//  Created by Andrey Ramirez on 7/16/22.
//

import Foundation

struct K {
    static let scoreComments = ["Teach me, senpai!", "Almost there!", "Not bad...", "Barely made it.", "Better luck next time!", "Brain not found!"]
    
    static func getScoreComment(_ score: Int) -> String {
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
}
