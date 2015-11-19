//
//  HeaterViewController.m
//  BeanStocks
//
//  Created by Anthony Tran on 11/16/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "HeaterViewController.h"
#import "UIView+Shake.h"
#import "CircularPower.h"
#import <PTDBean.h>
#import <PTDBeanManager.h>

@interface HeaterViewController () <PTDBeanDelegate,PTDBeanManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *temperature;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIImageView *heater2ImageView;
@property BOOL heatIsOn;

@property (strong,nonatomic) NSMutableDictionary *discoveredBeans;

@property (strong,nonatomic) PTDBeanManager *beanManager;
@property (strong,nonatomic) PTDBean *customBean;

@end

@implementation HeaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.discoveredBeans = [NSMutableDictionary dictionary];
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];

    self.heater2ImageView.image = [UIImage imageNamed:@"heater"];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissTemperature:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

    CircularLock *c = [[CircularLock alloc] initWithCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 100) radius:50
                                                  duration:1.5
                                               strokeWidth:15
                                                 ringColor:[UIColor blackColor]
                                               strokeColor:[UIColor blueColor]
                                               lockedImage:[UIImage imageNamed:@"lockedTransparent.png"]
                                             unlockedImage:[UIImage imageNamed:@"unlocked.png"]
                                                  isLocked:NO
                                         didlockedCallback:^{
                                             [self alertWithMessage:@"Heat is ON!"];
                                             self.heatIsOn = YES;
                                             [self toggled];
                                         }
                                       didUnlockedCallback:^{
                                           [self alertWithMessage:@"Heat is OFF!"];
                                           self.heatIsOn = NO;
                                           [self toggled];
                                       }];
    [self.view addSubview:c];
}

-(void)dismissTemperature:(UITapGestureRecognizer *)sender{
    [self.temperature resignFirstResponder];
}

- (void)toggled {
    if (self.heatIsOn == YES) {
        self.heater2ImageView.image = [UIImage imageNamed:@"heateron"];
        [self.customBean sendSerialString:@"TogglePowerOn\n"];
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:1.0f];
        [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
        [animation setType:@"waveEffect" ];
        [self.heater2ImageView.layer addAnimation:animation forKey:NULL];
        [self.heater2ImageView shakeWithOptions:SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndRestart | SCShakeOptionsAutoreverse force:0.15 duration:1 iterationDuration:0.03 completionHandler:nil];
    } else {
        self.heater2ImageView.image = [UIImage imageNamed:@"heater"];
        [self.customBean sendSerialString:@"TogglePowerOff\n"];
        [self.heater2ImageView endShake];
    }

}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.heater2ImageView endShake];

}

- (IBAction)onSetTemperaturePressed:(UIButton *)sender {
    if (self.customBean.state != BeanState_ConnectedAndValidated) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:@"Please connect to the bean first!"
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
    [self.temperature resignFirstResponder];
    int temperatureEntered = [self.temperature.text intValue];
    if (temperatureEntered < 1 || temperatureEntered > 50) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:@"Number has to be between 0 and 50!"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK Action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       NSLog(@"OK action");
                                   }];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        NSString *temperatureString = [NSString stringWithFormat:@"%d\n",temperatureEntered];
        [self.customBean sendSerialString:temperatureString];
        NSLog(@"NUMBER: %@",temperatureString);
    }
}

- (void)alertWithMessage:(NSString *)message{

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Fan status" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
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
    if ([bean.name isEqualToString:@"HeaterBean"] || [bean.name isEqualToString:@"Heater Bean"] || [bean.name isEqualToString:@"Bean"]){
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


- (IBAction)onConnectButtonPressed:(UIButton *)sender {
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
