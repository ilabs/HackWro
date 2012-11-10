//
//  MyLocation.h
//  Photrail
//
//  Created by Eugeniusz Keptia on 8/28/12.
//  Copyright (c) 2012 edzio27developer@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MyLocation.h"

@interface MyLocation : NSObject <MKAnnotation> {
    NSNumber *identyfier;
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    __weak NSString *dupa;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (copy) NSNumber *identyfier;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address 
        coordinate:(CLLocationCoordinate2D)coordinate identyfier:(NSNumber *) identyfier;
@end