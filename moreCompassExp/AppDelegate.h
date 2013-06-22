//
//  AppDelegate.h
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "VenueObject.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void) startStandardLocationServices;
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

//@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic)CLLocationManager*locationManager;
@property (strong, nonatomic) NSMutableArray * theItems;
@property (strong, nonatomic) VenueObject * closestVenue;

//@property (strong, nonatomic) CLLocationManager *locationManager;


@end

NSMutableArray * itemArray;
NSMutableArray * allItems1;
