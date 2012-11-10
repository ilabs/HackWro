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

#import "SHK.h"
#import "SHKFacebook.h"

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
    return [objectives count]+1;
}

- (float) sumTimes {
    float sum=0;
    for(int i=0; i< [objectives count]; i++){
        Objective *object = (Objective *)[objectives objectAtIndex:i];
        sum += object.completionTime;
    }
    NSLog(@"suma: %f", sum);
    return sum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"HWObjectiveCell";
    NSString *CellNib = @"HWObjectiveCell";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(indexPath.row == [objectives count]){
        [[cell nameLabel] setText:@"Łączny czas gry"];
        [[cell timeLabel] setText:[NSString stringWithFormat:@"%4.0f",[self sumTimes]]];
        return cell;
    }
    else {
    Objective *object = (Objective *)[objectives objectAtIndex:indexPath.row];
   
    [[cell nameLabel] setText:object.title];
    [[cell timeLabel] setText:[NSString stringWithFormat:@"%4.0f", object.completionTime]];
    
    return cell;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClicked)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonClicked
{
    NSString *facebookShareText = [NSString stringWithFormat:@"Melduje wykonanie zadania kapitanie!"];
    SHKItem *item = [SHKItem text:facebookShareText];
    [SHKFacebook shareItem:item];
}

@end
