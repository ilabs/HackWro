//
//  MainViewController.h
//  Hackwro
//
//  Created by Marek Kotewicz on 11/9/12.
//  Copyright (c) 2012 Marek Kotewicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@end
