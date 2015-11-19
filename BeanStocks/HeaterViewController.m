//
//  HeaterViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "HeaterViewController.h"
#import "UIView+Shake.h"

@interface HeaterViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *heater2ImageView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation HeaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.heater2ImageView.image = [UIImage imageNamed:@"heater"];
}

- (IBAction)onOffSegmentedControlToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.heater2ImageView.image = [UIImage imageNamed:@"heateron"];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"waveEffect" ];
        [self.heater2ImageView.layer addAnimation:animation forKey:NULL];
        [self.heater2ImageView shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
    } else {
        self.heater2ImageView.image = [UIImage imageNamed:@"heater"];
        [self.heater2ImageView endShake];
    }

}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.heater2ImageView endShake];
    
}

- (IBAction)connectButtonPressed:(UIButton *)sender {
}

@end
