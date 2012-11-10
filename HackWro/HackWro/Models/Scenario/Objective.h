//
//  Objective.h
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface Objective : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (assign) NSUInteger timeLimit;
@property (nonatomic, strong) NSString *objectiveDescription, *title;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) Location *targetLocation;


@end
