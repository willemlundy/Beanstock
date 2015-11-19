
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

// Main ImageView
@property (weak, nonatomic) IBOutlet UIImageView *coffeeImage;
@property (weak, nonatomic) IBOutlet UILabel *beanLabel;

@property (strong,nonatomic) NSMutableDictionary *discoveredBeans;
@property (strong,nonatomic) PTDBeanManager *beanManager;
@property (strong,nonatomic) PTDBean *customBean;

// Connected Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *connectedLED;
@property (weak, nonatomic) IBOutlet UIButton *connectedButton;

// Brew Type Properties
@property (weak, nonatomic) IBOutlet UIImageView *brewTypeLED;
@property (weak, nonatomic) IBOutlet UIButton *brewTypeButton;

// Prepped Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *preppedLED;
@property (weak, nonatomic) IBOutlet UIButton *preppedButton;

// Start Button Properties
@property (weak, nonatomic) IBOutlet UIImageView *startLED;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (strong,nonatomic) UIView *fillView;
@property (strong,nonatomic) UIView *progressView;
@property (weak, nonatomic) IBOutlet UISlider *brewSlider;

@property (strong,nonatomic) UILabel *percentage;
@property (assign,nonatomic) int percentCount;
@end

@implementation CoffeeStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.discoveredBeans = [NSMutableDictionary dictionary];
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];
    self.customBean.delegate = self;
    // UIImage variables
    UIImage *coffeePic = [UIImage imageNamed: @"Coffee-Cup-23"];
    UIImage *ligthblueLED = [UIImage imageNamed: @"ligthblue-led-circle-3-th"];
    UIImage *cyanLED = [UIImage imageNamed: @"cyan-led-circle-3-th"];
    UIImage *greenLED = [UIImage imageNamed: @"green1-led-circle-3-th"];
    UIImage *redLED = [UIImage imageNamed: @"red-led-circle-3-th"];
    UIImage *orangeLED = [UIImage imageNamed: @"orange-led-circle-th"];
    

    
    // Set Main Image
    [self.coffeeImage setImage:coffeePic];
    
    // Set up Connected Button
    [[self.connectedButton layer] setBorderWidth:1.0f];
    [[self.connectedButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.connectedLED setImage:greenLED];
    
    // Set up Brew Type Button
    [[self.brewTypeButton layer] setBorderWidth:1.0f];
    [[self.brewTypeButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.brewTypeButton setTitle:@"Regular" forState:UIControlStateNormal];
    [self.brewTypeLED setImage:ligthblueLED];
    
    // Set up Prepped Button
    [[self.preppedButton layer] setBorderWidth:1.0f];
    [[self.preppedButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.preppedButton setTitle:@"Not Prepped" forState:UIControlStateNormal];
    [self.preppedLED setImage:redLED];
 
    // Set up Start Button
    [[self.startButton layer] setBorderWidth:1.0f];
    [[self.startButton layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startLED setImage:orangeLED];
    
    
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
//    effectView.frame = self.view.bounds;
//    [self.view addSubview:effectView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startProgressView];
}

-(void)startProgressView{
    self.progressView = [[UIView alloc]initWithFrame:CGRectMake(0,0,150,150)];
    self.percentage = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    self.percentage.center = self.progressView.center;
    self.percentage.textAlignment = NSTextAlignmentCenter;
    self.percentage.textColor = [UIColor whiteColor];
    self.percentage.userInteractionEnabled = YES;
    self.percentage.font = [UIFont fontWithName:@"Arial" size:20];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTapsRequired = 1;
    [self.percentage addGestureRecognizer:tap];
    
    self.fillView = [[UIView alloc]initWithFrame:CGRectMake(self.progressView.frame.origin.x, self.progressView.frame.origin.y + 140, 150, 10)];
    self.fillView.backgroundColor = [UIColor colorWithRed:90/255.0 green:72/255.0 blue:60/255.0 alpha:1.0];
    
    self.progressView.center = CGPointMake(self.view.bounds.size.width/2.0,100);
    self.progressView.layer.cornerRadius = self.progressView.bounds.size.width/2.0;
    self.progressView.clipsToBounds = YES;
    self.progressView.layer.borderWidth = 4.0;
    self.progressView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    
    [self.view addSubview:self.progressView];
    [self.progressView addSubview:self.fillView];
    [self.progressView addSubview:self.percentage];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.fillView.frame = CGRectMake(0,150,150,-150);
    } completion:^(BOOL finished) { self.percentage.text = @"Brew Now!"; }];
}

-(void)tapped:(UIGestureRecognizer *)sender{
    [self makeCoffee];
}
- (IBAction)brewStrengthControl:(UISlider *)sender {
    self.fillView.backgroundColor = [UIColor colorWithRed:90/255.0 green:72/255.0 blue:60/255.0 alpha:sender.value/10.0];
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
    //self.beanLabel.text = @"Bean found! Tap to connect.";
    [self.connectedButton setTitle:@"Connect now!" forState:UIControlStateNormal];
}

- (void)BeanManager:(PTDBeanManager*)beanManager didConnectToBean:(PTDBean*)bean error:(NSError*)error{
    //self.beanLabel.text = @"Connected!";
    [self.connectedButton setTitle:@"Connected" forState:UIControlStateNormal];
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

-(void)bean:(PTDBean *)bean serialDataReceived:(NSData *)data{
    NSString *stringReceived = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",stringReceived);
}

#pragma mark - Connect to Coffee Machine
- (IBAction)connectToMachine:(UIButton *)sender {
    if (self.customBean.state == BeanState_Discovered) {
        self.customBean.delegate = self;
        [self.beanManager connectToBean:self.customBean error:nil];
    }
}

#pragma mark - Make Coffee
- (void)makeCoffee{
    //[self.customBean setLedColor:[UIColor blueColor]];
    [self.customBean sendSerialString:@"TogglePower\n"];
    self.percentage.text = @"";
    
    self.fillView.frame = CGRectMake(self.progressView.bounds.origin.x, self.progressView.frame.origin.y + 140, 150, 10);
    [UIView animateWithDuration:10.0 animations:^{
        self.fillView.frame = CGRectMake(0,150,150,-150);
    } completion:^(BOOL finished) { self.percentage.text = @"READY!"; }];
    
}




@end
