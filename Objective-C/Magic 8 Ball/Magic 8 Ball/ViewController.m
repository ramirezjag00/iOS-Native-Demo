//
//  ViewController.m
//  Magic 8 Ball
//
//  Created by Andrey Ramirez on 6/12/22.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
NSArray *ballArray = @[@"ball1", @"ball2", @"ball3", @"ball4", @"ball5"];

- (IBAction)askButtonPressed:(id)sender {
    UIImage *ballImage = [UIImage imageNamed: ballArray[arc4random() % [ballArray count]]];
    [_imageView setImage:ballImage];
}


@end
