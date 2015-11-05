//
//  SignUpViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.signUpButton.layer.cornerRadius = 5;
}

- (IBAction)onSignUpButtonTapped:(UIButton *)sender {
}


@end
