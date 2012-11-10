//
//  Event.h
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

typedef enum {
    EVENT_TYPE_DELAYED_MESSAGE,
    EVENT_TYPE_LOCATION_MESSAGE,
    EVENT_TYPE_MESSAGE
} EventType;

@interface Event : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (assign) EventType type;
@property (assign) NSUInteger delay;
@property (assign) BOOL didOccur;
@property (nonatomic, strong) NSString *content, *title;
@property (nonatomic, strong) Location *location;

@end
