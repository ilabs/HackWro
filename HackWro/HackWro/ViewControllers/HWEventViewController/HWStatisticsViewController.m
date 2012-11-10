//
//  HWViewController.m
//  cityGame
//
//  Created by Jakub Kaluzka on 10.11.2012.
//  Copyright (c) 2012 Jakub Kaluzka. All rights reserved.
//

#import "HWStatisticsViewController.h"

@interface HWStatisticsViewController ()

@end

@implementation HWStatisticsViewController

@synthesize titleLabel = _titleLabel;
@synthesize myNaivgationBar = _myNaivgationBar;
@synthesize myBack = _myBack;
@synthesize myTasks = _myTasks;
@synthesize myTimes = _myTimes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleLabel.text = @"Statystyki";
    _myNaivgationBar.topItem.title = @"Statystyki";
    _myBack.title = @"Wróć";
    _myTasks = [NSArray array];
    _myTimes = [NSArray array];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) userFinishedTasks:(NSArray *)noTasks inTimes:(NSArray *)Times {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
