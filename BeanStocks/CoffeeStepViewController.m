//
//  CoffeeStepViewController.m
//  BeanStocks
//
//  Created by William Lundy on 11/10/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "CoffeeStepViewController.h"

@interface CoffeeStepViewController ()

// Main ImageView
@property (weak, nonatomic) IBOutlet UIImageView *coffeeImage;

// Connected Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *connectedLED;
@property (weak, nonatomic) IBOutlet UIButton *connectedButton;

// Brew Type Properties
@property (weak, nonatomic) IBOutlet UIImageView *brewTypeLED;
@property (weak, nonatomic) IBOutlet UIButton *brewTypeButton;

// Prepped Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *preppedLED;
@property (weak, nonatomic) IBOutlet UIButton *preppedButton;

// Start Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *startLED;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation CoffeeStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *coffeePic = [UIImage imageNamed: @"Coffee-Cup-23"];
    UIImage *ligthblueLED = [UIImage imageNamed: @"ligthblue-led-circle-3-th"];
    UIImage *cyanLED = [UIImage imageNamed: @"cyan-led-circle-3-th"];
    UIImage *greenLED = [UIImage imageNamed: @"green1-led-circle-3-th"];
    UIImage *redLED = [UIImage imageNamed: @"red-led-circle-3-th"];
    UIImage *orangeLED = [UIImage imageNamed: @"orange-led-circle-th"];
    
    // Set Main Image
    [self.coffeeImage setImage:coffeePic];
    
    // Set up Connected Button
    [[self.connectedButton layer] setBorderWidth:1.0f];
    [[self.connectedButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.connectedLED setImage:greenLED];
    
    // Set up Brew Type Button
    [[self.brewTypeButton layer] setBorderWidth:1.0f];
    [[self.brewTypeButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.brewTypeButton setTitle:@"Regular" forState:UIControlStateNormal];
    [self.brewTypeLED setImage:ligthblueLED];
    
    // Set up Prepped Button
    [[self.preppedButton layer] setBorderWidth:1.0f];
    [[self.preppedButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.preppedButton setTitle:@"Not Prepped" forState:UIControlStateNormal];
    [self.preppedLED setImage:redLED];
 
    // Set up Start Button
    [[self.startButton layer] setBorderWidth:1.0f];
    [[self.startButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startLED setImage:orangeLED];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
