//
//  LoginViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.signUpButton.layer.cornerRadius = 5;
//    self.logInButton.layer.cornerRadius = 5;

}

- (IBAction)onLogInButtonTapped:(UIButton *)sender {
}

#pragma mark - Segue
// Going to main ViewController identifier - "ShowMainController"

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//}

@end
