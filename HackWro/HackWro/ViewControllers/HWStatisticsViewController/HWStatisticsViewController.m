//
//  HWViewController.m
//  cityGame
//
//  Created by Jakub Kaluzka on 10.11.2012.
//  Copyright (c) 2012 Jakub Kaluzka. All rights reserved.
//

#import "HWStatisticsViewController.h"
#import "Scenario.h"
#import "HWObjectiveCell.h"
#import "Objective.h"

@interface HWStatisticsViewController ()

@end

@implementation HWStatisticsViewController

@synthesize titleLabel = _titleLabel;
@synthesize myNaivgationBar = _myNaivgationBar;
@synthesize myBack = _myBack;
@synthesize myTasks = _myTasks;
@synthesize myTimes = _myTimes;

- (id) initWithObjectives:(NSArray*)objects {
    self = [super initWithNibName:@"HWStatisticsViewController" bundle:nil];
    if (self)
    {
        objectives = [NSArray arrayWithArray:objects];
    }
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

- (void) userFinishedTasks:(Scenario *)task
{
    NSLog(@"Uzytkownik ukonczyl %@ zadania w czasie",task);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section==0){
        return [objectives count];
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"HWObjectiveCell";
    NSString *CellNib = @"HWObjectiveCell";
    
    
   Objective *objective  = [objectives objectAtIndex:indexPath.row];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [[cell nameLabel] setText:objective.title];
    [[cell timeLabel] setText:[NSString stringWithFormat:@"%f", objective.completionTime]];
    return cell;
}

@end
