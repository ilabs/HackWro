//
//  Scenario.m
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import "Scenario.h"
#import "Objective.h"

@implementation Scenario

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if((self = [super init])) {
        self.scenarioDescription = [dictionary textObjectForKey:@"description"];
        self.title = [dictionary textObjectForKey:@"title"];
        
        id objective = [[dictionary objectForKey:@"objectives"] objectForKey:@"objective"];
        NSMutableArray *objectivesArray = [NSMutableArray new];
        
        for(NSDictionary *objectiveDictionary in [objective parsedElements]) {
            Objective *objective = [[Objective alloc] initWithDictionary:objectiveDictionary];
            [objectivesArray addObject:objective];
        }
        
        self.objectives = objectivesArray;
    }
    
    return self;
}

@end
