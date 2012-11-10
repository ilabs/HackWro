//
//  HWEventViewController.h
//  HackWro
//
//  Created by Marcin Raburski on 11/9/12.
//  Copyright (c) 2012 Marcin Raburski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ScenarioManager.h"

@interface HWEventViewController : UIViewController <CLLocationManagerDelegate, ScenarioManagerDelegate> {
    NSDate *startDate;
    Location *finishLocaton;
    Objective *currentObjective;
}

@property (nonatomic, strong) IBOutlet UIButton *mapButton;
@property (nonatomic, strong) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UIWebView *popupWebView;
@property (nonatomic, strong) ScenarioManager *scenarioManager;

@property (nonatomic, strong) IBOutlet UIView *popupView;
@property (nonatomic, strong) IBOutlet UIView *failView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andScenarioManager:(ScenarioManager*)manager;
- (void)startTimer:(NSTimeInterval)timeLeft;
- (IBAction)showMap:(id)sender;
- (IBAction)hidePopup:(id)sender;

- (IBAction)showPopup:(id)sender;
- (IBAction)questFailed:(id)sender;
- (IBAction)questFailedConfirmed:(id)sender;

@end
