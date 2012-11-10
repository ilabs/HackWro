//
//  Scenario.h
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scenario : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSArray *objectives;
@property (nonatomic, strong) NSString *scenarioDescription;

@end
