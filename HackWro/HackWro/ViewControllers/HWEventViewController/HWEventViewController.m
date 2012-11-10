//
//  HWEventViewController.m
//  HackWro
//
//  Created by Marcin Raburski on 11/9/12.
//  Copyright (c) 2012 Marcin Raburski. All rights reserved.
//

#import "HWEventViewController.h"

@interface HWEventViewController ()

@end

@implementation HWEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)hideSubviewsBackground:(UIView*)mainView {
    for (UIView *view in mainView.subviews) {
        view.backgroundColor = [UIColor clearColor];
        view.opaque = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = YES;
    self.popupWebView.backgroundColor = [UIColor clearColor];
    self.popupWebView.opaque = NO;
    [self hideSubviewsBackground:self.popupWebView];
    [self hideSubviewsBackground:self.webView];
    
    // test
    [self startTimer:10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startTimer:(NSTimeInterval)timeLeft {
    if (timeLeft > 0.0) {
        finishDate = [NSDate dateWithTimeIntervalSinceNow:timeLeft]; // to do, add time!
        timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1.0 target:self selector:@selector(timerUpdate:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    } else {
        self.timeLabel.text = @"Nieograniczony";
    }
}


- (NSString*)stringWithTimeInterval:(NSTimeInterval)interval {
    NSTimeInterval time = interval;
    NSTimeInterval timeHours = floor(time / 60.0 / 60.0);
    time -= timeHours * 60 * 60;
    NSTimeInterval timeMinutes = floor(time / 60.0);
    time -= timeMinutes * 60.0;
    if (timeHours > 0) {
        return [NSString stringWithFormat:@"%dh %dm %ds", (int)timeHours, (int)timeMinutes, (int)time];
    }
    if (timeMinutes > 0) {
        return [NSString stringWithFormat:@"%dm %ds", (int)timeMinutes, (int)time];
    }
    return [NSString stringWithFormat:@"%ds", (int)time];
}


- (void)timerUpdate:(NSNotification*)notif {
    if ([finishDate timeIntervalSinceNow] <= 0.0) {
        [timer invalidate];
        [self questFailed:nil];
    } else
        self.timeLabel.text = [self stringWithTimeInterval:[finishDate timeIntervalSinceNow]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.0f m", [currentLocation distanceFromLocation:finishLocaton]];
}

- (IBAction)showMap:(id)sender {

}

- (IBAction)hidePopup:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.popupView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.popupView removeFromSuperview];
    }];
}

- (IBAction)showPopup:(id)sender {
    self.popupView.frame = self.view.bounds;
    self.popupView.alpha = 0.0;
    [self.view addSubview:self.popupView];
    [UIView animateWithDuration:0.5 animations:^{
        self.popupView.alpha = 1.0;
    }];
}

- (IBAction)questFailed:(id)sender {
    self.failView.frame = self.view.bounds;
    self.failView.alpha = 0.0;
    [self.view addSubview:self.failView];
    [UIView animateWithDuration:0.5 animations:^{
        self.failView.alpha = 1.0;
    }];
}

- (IBAction)questFailedConfirmed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.failView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.failView removeFromSuperview];
    }];
}

@end
