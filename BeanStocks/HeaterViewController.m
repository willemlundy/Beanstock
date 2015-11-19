//
//  HeaterViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "HeaterViewController.h"
#import "UIView+Shake.h"
#import "CircularPower.h"

@interface HeaterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *heater2ImageView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property BOOL heatIsOn;

@end

@implementation HeaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.heater2ImageView.image = [UIImage imageNamed:@"heater"];

    self.view.backgroundColor = [UIColor whiteColor];

    CircularLock *c = [[CircularLock alloc] initWithCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 100) radius:50
                                                  duration:1.5
                                               strokeWidth:15
                                                 ringColor:[UIColor blackColor]
                                               strokeColor:[UIColor blueColor]
                                               lockedImage:[UIImage imageNamed:@"lockedTransparent.png"]
                                             unlockedImage:[UIImage imageNamed:@"unlocked.png"]
                                                  isLocked:NO
                                         didlockedCallback:^{
                                             [self alertWithMessage:@"Heat is ON!"];
                                             self.heatIsOn = YES;
                                             [self toggled];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"Heat is OFF!"];
                                           self.heatIsOn = NO;
                                           [self toggled];
                                       }];
    [self.view addSubview:c];
}

- (void)toggled {
    if (self.heatIsOn == YES) {
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


- (void)alertWithMessage:(NSString *)message{

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Fan status" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)connectButtonPressed:(UIButton *)sender {
}

@end
