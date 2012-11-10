//
//  Location.m
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import "Location.h"
#import "Event.h"

@implementation Location

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if((self = [super init])) {
        if([dictionary objectForKey:@"reach_event"]) {
            self.reachEvent = [[Event alloc] initWithDictionary:[dictionary objectForKey:@"reach_event"]];
        }
        
        self.title = [dictionary textObjectForKey:@"title"];
        
        id coordinates = [dictionary objectForKey:@"location_coordinates"];

        if(coordinates && [coordinates isKindOfClass:[NSDictionary class]]) {
            LocationCoordinates coords;
            coords.longitude = [[(NSDictionary *)coordinates textObjectForKey:@"longitude"] doubleValue];
            coords.latitude = [[(NSDictionary *)coordinates textObjectForKey:@"latitude"] doubleValue];
            self.coordinates = coords;
        }
    }
    
    return self;
}

- (double)distanceFromCLLocation:(CLLocation *)location {
    CLLocationCoordinate2D l2, l3;
    l2.latitude = self.coordinates.latitude;
    l2.longitude = self.coordinates.longitude;
    l3.latitude = location.coordinate.latitude;
    l3.longitude = location.coordinate.longitude;
    
    return MKMetersBetweenMapPoints(MKMapPointForCoordinate(l2), MKMapPointForCoordinate(l3));
    //return sqrt(pow((location.coordinate.latitude - self.coordinates.latitude), 2.0) + pow((location.coordinate.longitude - self.coordinates.longitude), 2.0));
}

@end
