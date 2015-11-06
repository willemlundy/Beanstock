//
//  LoginViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/4/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.signUpButton.layer.cornerRadius = 5;
//    self.logInButton.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard:)];
    [self.view addGestureRecognizer:tap];

}

- (IBAction)onLogInButtonTapped:(UIButton *)sender {
    
    if ([self.usernameField hasText] && [self.passwordField hasText]) {
        [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Sorry, the information you provided is incorrect!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [controller addAction:action];
                [self presentViewController:controller animated:YES completion:nil];
            }else{
                [self performSegueWithIdentifier:@"ShowMainController" sender:self];
            }
        }];
        
    }else{

        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Some of the information is missing. Try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

-(void)resignKeyboard:(UIGestureRecognizer *)sender{
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

#pragma mark - Segue
// Going to main ViewController identifier - "ShowMainController"

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//}

@end
