//
//  HWMapViewController.h
//  Newproject
//
//  Created by edzio27 on 12-11-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HWMapViewController : UIViewController <MKMapViewDelegate, MKAnnotation>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *points;

@end
