//
//  AnyObjectViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/18/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "AnyObjectViewController.h"

@interface AnyObjectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *anyObjectImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation AnyObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.anyObjectImageView.image = [UIImage imageNamed:@"starisoff"];
}

- (IBAction)onSegmentedControlToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.anyObjectImageView.image = [UIImage imageNamed:@"starison"];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"windEffect" ];
        [self.anyObjectImageView.layer addAnimation:animation forKey:NULL];
    } else {
        self.anyObjectImageView.image = [UIImage imageNamed:@"starisoff"];
    }
}

- (IBAction)connectButtonPressed:(UIButton *)sender {
}

@end
