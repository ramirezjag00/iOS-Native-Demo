//
//  ViewController.m
//  Dicee
//
//  Created by Andrey Ramirez on 6/12/22.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *diceImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *diceImageView2;

@end

@implementation ViewController
NSArray *diceFaces = @[@"DiceOne", @"DiceTwo", @"DiceThree", @"DiceFour", @"DiceFive", @"DiceSix"];

- (void)getRandomDiceFaces {
    
    UIImage *image1 = [UIImage imageNamed: diceFaces[arc4random() % [diceFaces count]]];
    UIImage *image2 = [UIImage imageNamed: diceFaces[arc4random() % [diceFaces count]]];
    [_diceImageView1 setImage:image1];
    [_diceImageView2 setImage:image2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRandomDiceFaces];
}
- (IBAction)rollButtonPress:(id)sender {
    [self getRandomDiceFaces];
}


@end
