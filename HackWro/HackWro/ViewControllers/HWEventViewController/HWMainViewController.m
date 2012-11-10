//
//  MainViewController.m
//  Hackwro
//
//  Created by Marek Kotewicz on 11/9/12.
//  Copyright (c) 2012 Marek Kotewicz. All rights reserved.
//

#import "HWMainViewController.h"

@interface HWMainViewController ()

@end

@implementation HWMainViewController

#pragma mark -
#pragma mark standard methods

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
    
    // load navigationBar
    self.navigationBar.topItem.title = @"Nazwa";
    self.navigationBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Dalej" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked)];
    self.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClicked)];
    

    self.labelText.text = @"tu jakis opis ";
    
    
    self.labelText.numberOfLines = 0;
    self.labelText.sizeToFit;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = self.labelText.frame.size;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNavigationBar:nil];
    [self setLabelText:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark actions

- (void)rightBarButtonClicked
{
    NSLog(@"right");
}

- (void)leftBarButtonClicked
{
    NSLog(@"left");
}

@end
