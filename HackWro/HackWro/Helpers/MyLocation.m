//
//  MyLocation.m
//  Photrail
//
//  Created by Eugeniusz Keptia on 8/28/12.
//  Copyright (c) 2012 edzio27developer@gmail.com. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation

@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize identyfier = _identyfier;

- (id)initWithName:(NSString*)name address:(NSString*)address 
        coordinate:(CLLocationCoordinate2D)coordinate identyfier:(NSNumber *)identyfiers {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        _identyfier = identyfiers;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (NSNumber *)identyfikator {
    return _identyfier;
}

@end