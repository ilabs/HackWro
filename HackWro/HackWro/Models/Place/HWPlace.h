//
//  HWPlace.h
//  Newproject
//
//  Created by edzio27 on 12-11-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HWPlace : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *address;

@end
