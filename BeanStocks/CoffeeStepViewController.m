//
//  CoffeeStepViewController.m
//  BeanStocks
//
//  Created by William Lundy on 11/10/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "CoffeeStepViewController.h"
#import <PTDBean.h>
#import <PTDBeanManager.h>

@interface CoffeeStepViewController () <PTDBeanDelegate,PTDBeanManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *coffeeImage;
@property (weak, nonatomic) IBOutlet UILabel *beanLabel;

@property (strong,nonatomic) NSMutableDictionary *discoveredBeans;
@property (strong,nonatomic) PTDBeanManager *beanManager;
@property (strong,nonatomic) PTDBean *customBean;
@end

@implementation CoffeeStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *coffeePic = [UIImage imageNamed: @"Coffee-Cup-23"];
    
    [self.coffeeImage setImage:coffeePic];
    
    self.discoveredBeans = [NSMutableDictionary dictionary];
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(connectToCoffeeMachine:)];
    [self.beanLabel addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BeanManagerDelegate Callbacks

- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager{
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        [self.beanManager startScanningForBeans_error:nil];
    }
    else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Bluetooth"
                                              message:@"Turn on Bluetooth to continue"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
}

- (void)BeanManager:(PTDBeanManager*)beanManager didDiscoverBean:(PTDBean*)bean error:(NSError*)error{
    NSUUID * key = bean.identifier;
    if (![self.discoveredBeans objectForKey:key]) {
        // New bean
        NSLog(@"BeanManager:didDiscoverBean:error %@", bean);
        [self.discoveredBeans setObject:bean forKey:key];
        self.customBean = [self.discoveredBeans.allValues objectAtIndex:0];
    }
    self.beanLabel.text = @"Bean found! Tap to connect.";
}

- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    self.beanLabel.text = @"Connected!";
    if (error) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:[error localizedDescription]
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    [self.beanManager stopScanningForBeans_error:&error];
    if (error) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:[error localizedDescription]
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
}

#pragma mark - Connect to Coffee Machine

-(void)connectToCoffeeMachine:(UIGestureRecognizer *)sender{
    NSLog(@"Tapped");
    if (self.customBean.state == BeanState_Discovered) {
        self.customBean.delegate = self;
        [self.beanManager connectToBean:self.customBean error:nil];
    }

    
}

#pragma mark - Make Coffee
- (IBAction)makeCoffeeButtonPressed:(UIButton *)sender {
    [self.customBean setLedColor:[UIColor blueColor]];
}



@end
