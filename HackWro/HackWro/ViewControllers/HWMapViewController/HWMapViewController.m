//
//  HWMapViewController.m
//  Newproject
//
//  Created by edzio27 on 12-11-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HWMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HWPlace.h"
#import "MyLocation.h"

static float minLon;
static float maxLon;
static float minLat;
static float maxLat;

@implementation HWMapViewController

@synthesize mapView = _mapView;
@synthesize points = _points;

- (NSMutableArray *) points {
    if(_points == nil) {
        _points = [[NSMutableArray alloc] init];
    }
    return _points;
}

-(NSArray*)createAnnotation:(NSMutableArray *) points {
    NSMutableArray *annotation = [NSMutableArray array];
    for (int i = 0; i < [self.points count]; i++) {
        [annotation addObject:[self.points objectAtIndex:i]];
    }
    return annotation;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    maxLat = FLT_MIN;
    maxLon = FLT_MIN;
    minLat = FLT_MAX;
    minLon = FLT_MAX;
    
    return self;
}

-(void) generateAnnotation {
    for(int i = 0; i < [self.points count]; i++) {
        HWPlace *place = [[HWPlace alloc] init];
        place = [self.points objectAtIndex:i];
        MyLocation *pin = [[MyLocation alloc] initWithName:place.name address:place.address coordinate:place.location.coordinate identyfier:[NSNumber numberWithInt:i]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:locale];
        dateFormatter.dateFormat = @"MMMM dd yyyy";
        
        [pin setAddress:place.address];
        [self.mapView addAnnotation:pin];
    }
}

- (void) zoomAndFit {
    if([self.points count] > 0) {
        for(int i = 0; i < [self.points count]; i++) {
            HWPlace *place = [self.points objectAtIndex:i];
            
            NSLog(@"lon %f", place.location.coordinate.longitude);
            NSLog(@"lat %f", place.location.coordinate.latitude);
            minLat = MIN(minLat, place.location.coordinate.latitude);
            minLon = MIN(minLon, place.location.coordinate.longitude);
            maxLat = MAX(maxLat, place.location.coordinate.latitude);
            maxLon = MAX(maxLon, place.location.coordinate.longitude);
        }
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 1.2*(maxLat - minLat);
        span.longitudeDelta = 1.2*(maxLon - minLon);
        
        CLLocationCoordinate2D location;
        location.latitude = (minLat + maxLat)/2;
        location.longitude = (minLon + maxLon)/2;
        
        region.span=span;
        region.center=location;
        [self.mapView setRegion:region animated:TRUE];
        [self.mapView regionThatFits:region];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"points: %@", [self.points[0] location]);
    [self generateAnnotation];
    [self zoomAndFit];
    //[self zoomAndFit];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *parkingAnnotationIdentifier=@"ParkingAnnotationIdentifier";
    if([annotation isKindOfClass:[MyLocation class]]){
        MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:parkingAnnotationIdentifier] ;
        customPinView.pinColor = MKPinAnnotationColorRed;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        HWPlace *place = [[HWPlace alloc] init];
        place = [self.points objectAtIndex:[((MyLocation *)annotation).identyfier integerValue]];
        
        CGRect rect = CGRectMake(0, 0, 30, 30);
        CGImageRef imageRef = CGImageCreateWithImageInRect([place.thumbnail CGImage], rect);
        UIImage *result = [UIImage imageWithCGImage:imageRef];
        
        UIImageView *memorialIcon = [[UIImageView alloc] initWithImage:result];
        customPinView.leftCalloutAccessoryView = memorialIcon;
        return customPinView;
    }
    return nil;
}

@end
