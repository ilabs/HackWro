//
//  HWStatsViewController.m
//  HackWro
//
//  Created by Paweł Nużka on 10.11.2012.
//  Copyright (c) 2012 ploomworks. All rights reserved.
//

#import "HWStatsViewController.h"
#import "HWObjectiveCell.h"
#import "Objective.h"

@interface HWStatsViewController ()

@end

@implementation HWStatsViewController
@synthesize objectives;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andObjectives:(NSArray *)array
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        objectives = array;
    }
    return self;
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
    
    Objective *object = (Objective *)[objectives objectAtIndex:indexPath.row];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    [[cell nameLabel] setText:object.title];
    [[cell timeLabel] setText:[NSString stringWithFormat:@"%f", object.completionTime]];
    
    return cell;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
