//
//  FanViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "FanViewController.h"
#import "UIView+Shake.h"
#import "CircularPower.h"

@interface FanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fan2ImageView;
@property BOOL fanIsOn;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation FanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fan2ImageView.image = [UIImage imageNamed:@"fanpic"];

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
                                             [self alertWithMessage:@"Fan is ON!"];
                                             self.fanIsOn = YES;
                                             [self toggled];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"Fan is OFF!"];
                                           self.fanIsOn = NO;
                                           [self toggled];
                                       }];
    [self.view addSubview:c];


}

- (void)toggled {



    if (self.fanIsOn == YES) {
        self.fan2ImageView.image = [UIImage imageNamed:@"fanon"];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"windEffect" ];
        [self.fan2ImageView.layer addAnimation:animation forKey:NULL];
        [self.fan2ImageView shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
    } else {
        self.fan2ImageView.image = [UIImage imageNamed:@"fanpic"];
        [self.fan2ImageView endShake];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.fan2ImageView endShake];

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
