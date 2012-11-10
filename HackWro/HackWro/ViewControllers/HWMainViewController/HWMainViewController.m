//
//  MainViewController.m
//  Hackwro
//
//  Created by Marek Kotewicz on 11/9/12.
//  Copyright (c) 2012 Marek Kotewicz. All rights reserved.
//

#import "HWMainViewController.h"
#import "ScenarioManager.h"
#import "HWEventViewController.h"
#import "HWStatsViewController.h"
@interface HWMainViewController ()

@end

@implementation HWMainViewController

#pragma mark -
#pragma mark standard methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        scenarioManager = [ScenarioManager new];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    
    for(UIView *subview in self.webView.subviews) {
        if([subview isKindOfClass:[UIScrollView class]]) {
            subview.backgroundColor = [UIColor clearColor];
            subview.opaque = NO;
            break;
        }
    }
    
    Scenario *scenario = [scenarioManager loadScenario:[[NSBundle mainBundle] pathForResource:@"miliony" ofType:@"xml"]];
    
    // load navigationBar
    self.navigationController.navigationBar.topItem.title = scenario.title;
    self.navigationController.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Dalej" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked)];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClicked)];
 
    [self.webView loadHTMLString:scenario.scenarioDescription baseURL:[[NSBundle mainBundle] resourceURL]];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark actions

- (void)rightBarButtonClicked
{
    HWEventViewController *event = [[HWEventViewController alloc]initWithNibName:@"HWEventViewController" bundle:nil andScenarioManager:scenarioManager];
    [self.navigationController pushViewController:event animated:YES];
}

- (void)leftBarButtonClicked
{
    NSLog(@"left");
}

@end
