//
//  HWMapViewController.h
//  Newproject
//
//  Created by edzio27 on 12-11-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HWMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSString *userLocation;

@end
