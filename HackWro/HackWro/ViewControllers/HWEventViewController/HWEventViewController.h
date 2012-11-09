//
//  HWEventViewController.h
//  HackWro
//
//  Created by Marcin Raburski on 11/9/12.
//  Copyright (c) 2012 Marcin Raburski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HWEventViewController : UIViewController <CLLocationManagerDelegate> {
    NSDate *finishDate;
    NSTimer *timer;
    CLLocationManager *locationManager;
    CLLocation *finishLocaton;
}

@property (nonatomic, strong) IBOutlet UIButton *mapButton;
@property (nonatomic, strong) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIWebView *popupWebView;

@property (nonatomic, strong) IBOutlet UIView *popupView;
@property (nonatomic, strong) IBOutlet UIView *failView;

- (void)startTimer:(NSTimeInterval)timeLeft;
- (IBAction)showMap:(id)sender;
- (IBAction)hidePopup:(id)sender;

- (IBAction)showPopup:(id)sender;
- (IBAction)questFailed:(id)sender;
- (IBAction)questFailedConfirmed:(id)sender;
@end
