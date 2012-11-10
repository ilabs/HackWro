//
//  HWStatsViewController.h
//  HackWro
//
//  Created by Paweł Nużka on 10.11.2012.
//  Copyright (c) 2012 ploomworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWStatsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *objectives;
}
@property (nonatomic, strong) NSArray *objectives;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andObjectives:(NSArray *)array;
@end
