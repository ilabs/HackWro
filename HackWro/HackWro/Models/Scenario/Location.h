//
//  Location.h
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Event;

typedef struct {
    double latitude, longitude;
} LocationCoordinates;

@interface Location : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (double)distanceFromCLLocation:(CLLocation *)location;

@property (nonatomic, strong) Event *reachEvent;
@property (assign) LocationCoordinates coordinates;

@end
