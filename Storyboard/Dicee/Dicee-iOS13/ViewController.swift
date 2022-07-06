//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let diceFaces: [String] = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"];
    //  ctrl + click + drag image to the line in ViewController after class, will declare a variable of the UIImageView
    //  IBOutlet allows me to reference a UI Element to change the attributes
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    // get random face of Dice images, using an array of strings
    func getRandomDiceFaces() -> Void {
        //  using diceImageView1.image = #imageLiteral( where this syntax
        //        diceImageView2.image = #imageLiteral(resourceName: "DiceThree");
        //  using var diceImageView1 and property image as seen in the attribute pane — we’re reassigning the #imageLiteral to another image on load since this block is added in life cycle viewDidLoad
        
        //  these two are the same
        //  diceImageView1.image = #imageLiteral(resourceName: "DiceSix");
        //  diceImageView1.image = UIImage(imageLiteralResourceName: "DiceOne");
        diceImageView1.image = UIImage(imageLiteralResourceName: diceFaces.randomElement()!);
        diceImageView2.image = UIImage(imageLiteralResourceName: diceFaces.randomElement()!);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomDiceFaces();
        
    }
    
    //  IBAction allows me to reference a UI Element but as an action
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        getRandomDiceFaces();
    }
    

}

