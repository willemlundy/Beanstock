//
//  AnyObjectViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/18/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "AnyObjectViewController.h"
#import "UIView+Shake.h"
#import "CircularPower.h"

@interface AnyObjectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *anyObjectImageView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property BOOL objectIsOn;

@end

@implementation AnyObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.anyObjectImageView.image = [UIImage imageNamed:@"starisoff"];

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
                                             [self alertWithMessage:@"Object is ON!"];
                                             self.objectIsOn = YES;
                                             [self toggled];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"Object is OFF!"];
                                           self.objectIsOn = NO;
                                           [self toggled];
                                       }];
    [self.view addSubview:c];

}

- (void)toggled {
    if (self.objectIsOn == YES) {
        self.anyObjectImageView.image = [UIImage imageNamed:@"starison"];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"windEffect" ];
        [self.anyObjectImageView.layer addAnimation:animation forKey:NULL];
        [self.anyObjectImageView shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
    } else {
        self.anyObjectImageView.image = [UIImage imageNamed:@"starisoff"];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.anyObjectImageView endShake];

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
