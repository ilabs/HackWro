//
//  MainViewController.h
//  Hackwro
//
//  Created by Marek Kotewicz on 11/9/12.
//  Copyright (c) 2012 Marek Kotewicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScenarioManager;

@interface HWMainViewController : UIViewController
{
    ScenarioManager*    scenarioManager;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
