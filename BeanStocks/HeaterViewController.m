//
//  HeaterViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "HeaterViewController.h"

@interface HeaterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heaterImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *heater2ImageView;

@end

@implementation HeaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heaterImageView.image = [UIImage imageNamed:@"off"];
    self.heater2ImageView.image = [UIImage imageNamed:@"heater"];
}

- (IBAction)onOffSegmentedControlToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.heaterImageView.image = [UIImage imageNamed:@"on"];
    } else {
        self.heaterImageView.image = [UIImage imageNamed:@"off"];
    }
}


@end
