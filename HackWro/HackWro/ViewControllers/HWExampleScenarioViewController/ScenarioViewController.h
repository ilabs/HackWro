//
//  ScenarioViewController.h
//  HackWroApp
//
//  Created by Michal Jodko on 11/10/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenarioManager.h"

@interface ScenarioViewController : UIViewController<ScenarioManagerDelegate> {
    ScenarioManager *scenarioManager;
}

- (IBAction)startScenario:(id)sender;

@property (nonatomic, strong) IBOutlet UIWebView *descriptionWebView;
@property (nonatomic, strong) IBOutlet UILabel *timeLeftLabel, *distanceLabel;
@property (nonatomic, strong) IBOutlet UIButton *runScenarioButton;

@end
