//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Story {
    let title:  String
    let choice1: String
    let choice2: String
    let choice1Destination: Int
    let choice2Destination: Int
    
    init(t: String, c1: String, c2: String, c1d: Int, c2d: Int) {
        self.title = t
        self.choice1 = c1
        self.choice2 = c2
        self.choice1Destination = c1d
        self.choice2Destination = c2d
    }
}
