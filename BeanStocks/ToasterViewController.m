//
//  ToasterViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "ToasterViewController.h"

@interface ToasterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *toasterImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;

@end

@implementation ToasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toasterImageView.image = [UIImage imageNamed:@"toaster"];
//    self.toasterImageView.backgroundColor = [UIColor greenColor];
}

- (IBAction)onOffSegmentedToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.toasterImageView.image = [UIImage imageNamed:@"toasteron"];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"waveEffect" ];
        [self.toasterImageView.layer addAnimation:animation forKey:NULL];
    } else {
        self.toasterImageView.image = [UIImage imageNamed:@"toaster"];
    }

}


@end
