//
//  LightViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "LightViewController.h"
#import <PTDBean.h>
#import <PTDBeanManager.h>

@interface LightViewController () <PTDBeanDelegate,PTDBeanManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *lightBulbImageView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *onOffSegmentControl;
@property (strong,nonatomic) NSMutableDictionary *discoveredBeans;

@property (strong,nonatomic) PTDBeanManager *beanManager;
@property (strong,nonatomic) PTDBean *customBean;
@end

@implementation LightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.discoveredBeans = [NSMutableDictionary dictionary];
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];
    
    self.customBean.delegate = self;
    self.beanManager.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.lightBulbImageView.image = [UIImage imageNamed:@"offlightbulb"];
}
- (IBAction)onOrOffButtonTapped:(UISegmentedControl *)sender {
    if (self.onOffSegmentControl.selectedSegmentIndex == 1) {
        self.lightBulbImageView.image = [UIImage imageNamed:@"onlightbulb"];
        [self.customBean sendSerialString:@"TogglePowerOn\n"];
    } else {
        self.lightBulbImageView.image = [UIImage imageNamed:@"offlightbulb"];
        [self.customBean sendSerialString:@"TogglePowerOff\n"];
    }

}

#pragma mark - BeanManagerDelegate Callbacks

- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager{
    NSLog(@"SSState: %lu",(unsigned long)manager.state);
    NSLog(@"SSState: %lu",(unsigned long)self.beanManager.state);
    
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
    NSLog(@"BEAN NAME: %@",bean.name);
    NSLog(@"%@",key);
    NSLog(@"BBBState: %lu",(unsigned long)self.customBean.state);
    if (![self.discoveredBeans objectForKey:key]) {
        // New bean
        NSLog(@"BeanManager:didDiscoverBean:error %@", bean);
        [self.discoveredBeans setObject:bean forKey:key];
        
        //[self.discoveredBeans.allValues objectAtIndex:0];
        for (PTDBean *bean in self.discoveredBeans.allValues) {
            [self isLightBeanFound:bean];
        }
    }
    //self.beanLabel.text = @"Bean found! Tap to connect.";
    [self.connectButton setTitle:@"Connect now!" forState:UIControlStateNormal];
}

-(void)isLightBeanFound:(PTDBean *)bean{
    if ([bean.name isEqualToString:@"LampBean"] || [bean.name isEqualToString:@"Lamp Bean"]){// ||  [bean.name isEqualToString:@"Coffee"]) {
        self.customBean = bean;
    }else{
        //[self.connectedButton setTitle:@"Not found!" forState:UIControlStateNormal];
        NSLog(@"BEAN NAME: %@",bean.name);
    }
    
}

- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    //self.beanLabel.text = @"Connected!";
    [self.connectButton setTitle:@"Connected" forState:UIControlStateNormal];
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
- (IBAction)connectButton:(UIButton *)sender {
    if (self.customBean.state == BeanState_Discovered) {
        self.customBean.delegate = self;
        [self.beanManager connectToBean:self.customBean error:nil];
    }
}

-(void)bean:(PTDBean *)bean serialDataReceived:(NSData *)data{
    NSString *stringReceived = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",stringReceived);
//    if ([stringReceived isEqualToString:@"Button One Pressed"]) {
//        //NSLog(@"Button one pressed");
//    } else if([stringReceived isEqualToString:@"Button Two Pressed"]){
//        NSLog(@"Button Two pressed");
//    }else if ([stringReceived isEqualToString:@"Power Toggled"]){
//        NSLog(@"Power Toggled");
//    }else if ([stringReceived isEqualToString:@"Brew Toggled"]){
//        NSLog(@"Brew Toggled");
//    }else{
//        NSLog(@"Unrecognized: %@",stringReceived);
//    }
}

#pragma mark - Cleanup Code
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.beanManager disconnectBean:self.customBean error:nil];
    [self.discoveredBeans removeAllObjects];
    
    NSLog(@"BEAN STATE: %ld",(long)self.customBean.state);
    NSLog(@"COUNT: %lu",self.discoveredBeans.count);
}

@end
