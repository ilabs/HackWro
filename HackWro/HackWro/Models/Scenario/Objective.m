//
//  Objective.m
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import "Objective.h"
#import "Location.h"
#import "Event.h"

@implementation Objective

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if((self = [super init])) {
        self.timeLimit = [[dictionary textObjectForKey:@"time_limit"] integerValue];
        self.objectiveDescription = [dictionary textObjectForKey:@"description"];
        self.targetLocation = [[Location alloc] initWithDictionary:[dictionary objectForKey:@"target_location"]];
        
        id event = [[dictionary objectForKey:@"events"] objectForKey:@"event"];
        NSMutableArray *eventsArray = [NSMutableArray new];
        
        for(NSDictionary *eventDictionary in [event parsedElements]) {
            Event *event = [[Event alloc] initWithDictionary:eventDictionary];
            [eventsArray addObject:event];
        }
        
        self.events = eventsArray;
    }
    
    return self;
}

@end
