//
//  HWPlace.m
//  Newproject
//
//  Created by edzio27 on 12-11-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWPlace.h"

@implementation HWPlace

@synthesize name = _name;
@synthesize subtitle = _subtitle;
@synthesize thumbnail = _thumbnail;
@synthesize location = _location;
@synthesize address = _address;
@synthesize lat = _lat;
@synthesize lon = _lon;

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:UIImageJPEGRepresentation(self.thumbnail, 1.0f) forKey:@"thumbnail"];
    [aCoder encodeDouble:self.location.coordinate.latitude forKey:@"latitude"];
    [aCoder encodeDouble:self.location.coordinate.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.lat forKey:@"lat"];
    [aCoder encodeObject:self.lon forKey:@"lon"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [[HWPlace alloc] init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.thumbnail = [UIImage imageWithData:[aDecoder decodeObjectForKey:@"thumbnail"]];
        self.lat = [aDecoder decodeObjectForKey:@"lat"];
        self.lon = [aDecoder decodeObjectForKey:@"lon"];
    }
    return self;
}


@end
