//
//  HWEventViewController.m
//  HackWro
//
//  Created by Marcin Raburski on 11/9/12.
//  Copyright (c) 2012 Marcin Raburski. All rights reserved.
//

#import "HWEventViewController.h"
#import "HWStatisticsViewController.h"
#import "HWMapViewController.h"
#import "HWPlace.h"

@interface HWEventViewController ()

@end

@implementation HWEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andScenarioManager:(ScenarioManager*)manager {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scenarioManager = manager;
        self.scenarioManager.delegate = self;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

    [self.scenarioManager runScenario];

}

- (void)hideSubviewsBackground:(UIView*)mainView {
    for (UIView *view in mainView.subviews) {
        view.backgroundColor = [UIColor clearColor];
        view.opaque = NO;
        if ([view isKindOfClass:[UIScrollView class]]) {
            for (UIView *view2 in view.subviews)
                if ([view2 isKindOfClass:[UIImageView class]]) {
                    view2.hidden = YES;
                }
        }
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)showMap:(id)sender {
    HWPlace *place = [[HWPlace alloc] init];
    place.location = [[CLLocation alloc] initWithLatitude:currentObjective.targetLocation.coordinates.latitude longitude:currentObjective.targetLocation.coordinates.longitude];
    place.name = finishLocaton.title;
    HWMapViewController *mapViewController = [[HWMapViewController alloc] initWithNibName:@"HWMapViewController" bundle:nil];
    [mapViewController setPoints:@[place]];
    mapViewController.title = place.name;
    [self.navigationController pushViewController:mapViewController animated:YES];
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

- (void)scenarioManager:(ScenarioManager *)scenarioManager didLoadObjective:(Objective *)objective {
    if (currentObjective) {
        currentObjective.completionTime = [startDate timeIntervalSinceNow]*-1.0;
    }
    
    [self.webView loadHTMLString:objective.objectiveDescription baseURL:nil];
    self.timeLabel.font = [UIFont boldSystemFontOfSize:20];
    self.timeLabel.text = @"Nieograniczony";
    currentObjective = objective;
    startDate = [NSDate date];
    [self.mapButton setTitle:objective.targetLocation.title forState:UIControlStateNormal];
    
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager didFailWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Błąd!" message:@"Mam problem z załadowaniem czegoś. Przeraszamy!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager timeLeftChanged:(NSUInteger)timeLeft {
    self.timeLabel.font = [UIFont boldSystemFontOfSize:39];
    self.timeLabel.text = [self stringWithTimeInterval:timeLeft];

}

- (void)scenarioManager:(ScenarioManager *)scenarioManager objectiveFailed:(Objective *)objective {
    [self questFailed:nil];
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager eventOccurred:(Event *)event {
    [self.navigationController popToViewController:self animated:YES];
    [self.popupWebView loadHTMLString:event.content baseURL:nil];
    [self showPopup:nil];
}

- (void)scenarioManager:(ScenarioManager *)scenarioManager locationUpdated:(CLLocation *)currentLocation {
    MKMapPoint p1 = MKMapPointForCoordinate(currentLocation.coordinate);
    CLLocationCoordinate2D loc;
    loc.latitude = finishLocaton.coordinates.latitude;
    loc.longitude = finishLocaton.coordinates.longitude;
    MKMapPoint p2 = MKMapPointForCoordinate(loc);
    CLLocationDistance dist = MKMetersBetweenMapPoints(p1, p2);
    self.distanceLabel.text = [NSString stringWithFormat:@"%.0f m", dist];

}

- (void)scenarioManager:(ScenarioManager *)scenarioManager scenarioCompleted:(Scenario *)scenario {
    HWStatisticsViewController *stats = [[HWStatisticsViewController alloc] initWithNibName:@"HWStatisticsViewController" bundle:nil];
    [self.navigationController pushViewController:stats animated:YES];
}

@end
