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
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *fan2ImageView;

@end

@implementation FanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fan2ImageView.image = [UIImage imageNamed:@"fanpic"];

    self.view.backgroundColor = [UIColor whiteColor];

    CircularLock *c = [[CircularLock alloc] initWithCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 100)
                                                    radius:50
                                                  duration:1.5
                                               strokeWidth:15
                                                 ringColor:[UIColor orangeColor]
                                               strokeColor:[UIColor blackColor]
                                               lockedImage:[UIImage imageNamed:@"lockedTransparent.png"]
                                             unlockedImage:[UIImage imageNamed:@"unlocked.png"]
                                                  isLocked:NO
                                         didlockedCallback:^{
                                             [self alertWithMessage:@"Fan is ON!"];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"Fan is OFF!"];
                                       }];
    [self.view addSubview:c];


//    [self startApp];
}

//- (IBAction)onOffSegmentedControlToggled:(UISegmentedControl *)sender {
//
////    [self startApp];
//
//    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
//        self.fan2ImageView.image = [UIImage imageNamed:@"fanon"];
//        CATransition *animation = [CATransition animation];
//        [animation setDelegate:self];
//        [animation setDuration:1.0f];
//        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
//        [animation setType:@"windEffect" ];
//        [self.fan2ImageView.layer addAnimation:animation forKey:NULL];
//        [self.fan2ImageView shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
//    } else {
//        self.fan2ImageView.image = [UIImage imageNamed:@"fanpic"];
//        [self.fan2ImageView endShake];
//    }
//}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.fan2ImageView endShake];

}
//- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration
//            curve:(int)curve x:(CGFloat)x y:(CGFloat)y
//{
//    // Setup the animation
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:duration];
//    [UIView setAnimationCurve:curve];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//
//    // The transform matrix
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
//    image.transform = transform;
//
//    // Commit the changes
//    [UIView commitAnimations];
//    
//}
//
//- (void)startApp
//{
//    UIImageView *imageToMove =
//    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fanpic"]];
//    imageToMove.frame = CGRectMake(10, 10, 20, 100);
//    [self.view addSubview:imageToMove];
//
//    // Move the image
//    [self moveImage:imageToMove duration:3.0
//              curve:UIViewAnimationCurveLinear x:116.0 y:129.0];
//    
//
//    
//}
- (void)alertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



@end
