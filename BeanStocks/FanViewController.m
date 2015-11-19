//
//  FanViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "FanViewController.h"
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface FanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fanImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *fan2ImageView;

@end

@implementation FanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.fanImageView.image = [UIImage imageNamed:@"off"];
    //self.fan2ImageView.image = [UIImage imageNamed:@"fan"];
    
    self.fan2ImageView.image = [UIImage imageNamed:@"fan-1"];
}

- (IBAction)onOffSegmentedControlToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        
        [UIView animateWithDuration:2.0 animations:^{
            self.fan2ImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
        } completion:^(BOOL finished){
            self.fan2ImageView.transform = CGAffineTransformIdentity;
        }];
        
        
    } else {
        self.fanImageView.image = [UIImage imageNamed:@"off"];
    }
}



@end
