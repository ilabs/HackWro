//
//  HWAppDelegate.h
//  HackWro
//
//  Created by Paweł Nużka on 09.11.2012.
//  Copyright (c) 2012 ploomworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWEventViewController.h"

@class HWMainViewController;

@interface HWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HWMainViewController *mainViewController;

@end
