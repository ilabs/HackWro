//
//  Event.m
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import "Event.h"
#import "Location.h"

@implementation Event

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if((self = [super init])) {
        NSString *typeString = [dictionary objectForKey:@"type"];
        
        if([typeString isEqualToString:@"delayed_message"]) {
            self.type = EVENT_TYPE_DELAYED_MESSAGE;
            self.delay = [[dictionary textObjectForKey:@"delay"] integerValue];
        } else if([typeString isEqualToString:@"location_message"]) {
            self.type = EVENT_TYPE_LOCATION_MESSAGE;
            self.location = [[Location alloc] initWithDictionary:[dictionary objectForKey:@"location"]];
        } else if([typeString isEqualToString:@"message"]) {
            self.type = EVENT_TYPE_MESSAGE;
        }
        
        self.didOccur = NO;
        self.content = [dictionary textObjectForKey:@"title"];
        self.content = [dictionary textObjectForKey:@"content"];
    }
    
    return self;
}

@end
