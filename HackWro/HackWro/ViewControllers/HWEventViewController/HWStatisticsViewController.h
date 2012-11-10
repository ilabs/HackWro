//
//  HWViewController.h
//  cityGame
//
//  Created by Jakub Kaluzka on 10.11.2012.
//  Copyright (c) 2012 Jakub Kaluzka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWStatisticsViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UINavigationBar *myNaivgationBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *myBack;

@property (nonatomic, retain) NSArray *myTimes;
@property (nonatomic, retain) NSArray *myTasks;

@end
