//
//  LightViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "LightViewController.h"

@interface LightViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *lightBulbImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;


@end

@implementation LightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.lightBulbImageView.image = [UIImage imageNamed:@"offlightbulb"];

}

-(void)viewWillAppear:(BOOL)animated{
    self.lightBulbImageView.image = [UIImage imageNamed:@"offlightbulb"];
}
- (IBAction)onOrOffButtonTapped:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.lightBulbImageView.image = [UIImage imageNamed:@"onlightbulb"];
    } else {
        self.lightBulbImageView.image = [UIImage imageNamed:@"offlightbulb"];
    }

}



@end
