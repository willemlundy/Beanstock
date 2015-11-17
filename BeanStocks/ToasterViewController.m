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
    self.toasterImageView.image = [UIImage imageNamed:@"bread"];
//    self.toasterImageView.backgroundColor = [UIColor greenColor];
}

- (IBAction)onOffSegmentedToggled:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.toasterImageView.image = [UIImage imageNamed:@"toasting"];
    } else {
        self.toasterImageView.image = [UIImage imageNamed:@"bread"];
    }

}


@end
