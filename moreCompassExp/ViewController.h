//
//  ViewController.h
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *saiImage;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueLabel;
@property (strong, nonatomic) IBOutlet UILabel *japaneseNameLabel;
@property (strong, nonatomic) NSString * theDistance;

@property (strong, nonatomic) IBOutlet UILabel *theDistanceLabel;

@property(strong, nonatomic) NSMutableArray *FUCKYOU;
@end


CLLocationManager *locationManager;
float thisVenueLat;
float thisVenueLong;
float thisDistVenueLat;
float thisDistVenueLong;