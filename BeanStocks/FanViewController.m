//
//  FanViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "FanViewController.h"

@interface FanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *fanImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *fan2ImageView;

@end

@implementation FanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fanImageView.image = [UIImage imageNamed:@"off"];
    self.fan2ImageView.image = [UIImage imageNamed:@"fan"];
}

- (IBAction)onOffSegmentedControlToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.fanImageView.image = [UIImage imageNamed:@"on"];
    } else {
        self.fanImageView.image = [UIImage imageNamed:@"off"];
    }
}

@end
