//
//  LoginViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signUpButton.layer.cornerRadius = 5;
    self.logInButton.layer.cornerRadius = 5;

}
- (IBAction)onSignUpButtonTapped:(UIButton *)sender {

}
- (IBAction)onLogInButtonTapped:(UIButton *)sender {
}



@end
