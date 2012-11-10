//
//  ScenarioViewController.m
//  HackWroApp
//
//  Created by Michal Jodko on 11/10/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import "ScenarioViewController.h"

@interface ScenarioViewController ()

@end

@implementation ScenarioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self) {
        scenarioManager = [ScenarioManager new];
        scenarioManager.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.descriptionWebView.backgroundColor = [UIColor clearColor];
    self.descriptionWebView.opaque = NO;
    
    for(UIView *subview in self.descriptionWebView.subviews) {
        if([subview isKindOfClass:[UIScrollView class]]) {
            subview.backgroundColor = [UIColor clearColor];
            subview.opaque = NO;
            break;
        }
    }
    
    Scenario *scenario = [scenarioManager loadScenario:[[NSBundle mainBundle] pathForResource:@"miliony" ofType:@"xml"]];
    
    if(!scenario) {
        self.runScenarioButton.hidden = YES;
        return;
    }
    
    [self.descriptionWebView loadHTMLString:scenario.scenarioDescription baseURL:[[NSBundle mainBundle] resourceURL]];
}

- (void)startScenario:(id)sender {
    [scenarioManager runScenario];
    self.runScenarioButton.hidden = YES;
}


#pragma mark - ScenarioManagerDelegate


- (void)scenarioManager:(ScenarioManager *)scenarioManager didLoadObjective:(Objective *)objective {
    [self.descriptionWebView loadHTMLString:objective.objectiveDescription baseURL:nil];
    
    if(objective.timeLimit > 0) {
        self.timeLeftLabel.hidden = NO;
    } else {
        self.timeLeftLabel.hidden = YES;
    }
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager didFailWithError:(NSError *)error {
    [self.descriptionWebView loadHTMLString:[NSString stringWithFormat:@"Error: %@", error.description] baseURL:nil];
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager objectiveFailed:(Objective *)objective {
    [self.descriptionWebView loadHTMLString:@"Zjebałeś!" baseURL:nil];
    self.runScenarioButton.hidden = NO;
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager timeLeftChanged:(NSUInteger)timeLeft {
    self.timeLeftLabel.text = [NSString stringWithFormat:@"%02d:%02d", (timeLeft / 60), (timeLeft % 60)];
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager eventOccurred:(Event *)event {
    [self.descriptionWebView loadHTMLString:event.content baseURL:nil];
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager locationUpdated:(CLLocation *)location {
    
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager scenarioCompleted:(Scenario *)scenario {
    
}

@end
