//
//  ViewController.m
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import "ViewController.h"
#import "VenueObject.h"
#import "AppDelegate.h"
//#import "AppDelegate.m"
#import "LocalVenueClass.h"


@interface ViewController ()


{

    VenueObject* oneVenue;
    NSMutableArray *arrayWithDistance;
    NSArray *distanceSortedArray;
    NSString *latitudeWithCurrentCoordinates;
    NSString *longitudeWithCurrentCoordinates;
    float ourPhoneFloatLat;
    float ourPhoneFloatLong;
    VenueObject *selectedVenue;
    NSMutableArray * allItems1;
    //NSMutableArray * sushiPlace;
}


    
#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiandsToDegrees(x) (x * 180.0 / M_PI)

    
   
@property (retain, nonatomic) IBOutlet UILabel *nearestPlaceLabel;

@property (nonatomic, strong) NSString * strLatitude;
@property (nonatomic, strong) NSString * strLongitude;
@property (strong, nonatomic)CLLocationManager*locationManager;
    
@end

@implementation ViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:(NSCoder *)aDecoder];
    
    //    [self StartStandardLocationServices];
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //        [self StartStandardLocationServices];
        //        NSLog(@"test");
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self startStandardLocationServices];
    
}


-(void) startStandardLocationServices
{
    
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
    
    
    [locationManager startUpdatingLocation];
    
    
    if([CLLocationManager headingAvailable]) {
        
        [locationManager startUpdatingHeading];
    } else {
        NSLog(@"Location Heading/Compass FAIL");
        
        
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* startLocation = [locations lastObject];
    NSDate* eventDate = startLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        //            NSLog(@"latitude %+.6f, longitude %+.6f\n", startLocation.coordinate.latitude, startLocation.coordinate.longitude);
        
        ourPhoneFloatLat = startLocation.coordinate.latitude;
        ourPhoneFloatLong = startLocation.coordinate.longitude;
        
        //    float remainingDistance = startLocation - [locations objectAtIndex[0];
        
        
        
        self.strLatitude = [NSString stringWithFormat: @"%f", startLocation.coordinate.latitude];
        self.strLongitude = [NSString stringWithFormat: @"%f", startLocation.coordinate.longitude];
        //  [self fuck];
}
    //  [self fuck];
    //}
    
    //-(void)fuck
    //{
    //
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    

     AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    VenueObject * thisNearPlace = [[VenueObject alloc] init];
    thisNearPlace = appDelegate.closestVenue;
    
    NSString *nearPlaceName = thisNearPlace.title;
    NSLog(@"%@", nearPlaceName);
    
    
   
    
    
    
    thisVenueLat = [appDelegate.closestVenue.placeLatitude floatValue];
    thisVenueLong = [appDelegate.closestVenue.placeLongitude floatValue];
    //NSLog(@"%f", thisVenueLong);
    
    float radcurrentLat = degreesToRadians(ourPhoneFloatLat);
    float radcurrentLong = degreesToRadians(ourPhoneFloatLong);
    float radthisVenueLat = degreesToRadians(thisVenueLat);
    float radthisVenueLong = degreesToRadians(thisVenueLong);
    //
    float deltLat = (radthisVenueLat - radcurrentLat);
    float deltLong = (radthisVenueLong - radcurrentLong);
    
    float y = sinf(deltLong) * cosf(radthisVenueLat);
    float x = (cosf(radcurrentLat) * sinf(radthisVenueLat)) - ((sinf(radcurrentLat) *cosf(radthisVenueLat)) * cosf(deltLong));
    float radRotateAngle = atan2f(y, x);
    float initialVenueBearing = radRotateAngle;
    float VenueBearDeg;
    
    float initialVenueBearingDegrees = initialVenueBearing * 180/M_PI;
    
    if (initialVenueBearingDegrees < 0) {
        VenueBearDeg = initialVenueBearingDegrees + 360;
    }
    else{
        VenueBearDeg = initialVenueBearingDegrees;
    };
    
    //
    //
    //NSLog(@"Initial bearing/initial angle rotation in radians is = %f", radRotateAngle);
    //    float degRotateAngle = radiandsToDegrees(radRotateAngle);
    NSLog(@"Initial bearing/initial angle rotation in degrees is = %f", VenueBearDeg);
    //
    //    test uncomment end here
    //
    //	// Convert Degree to Radian and move the needle
    float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
    //
    float newRad =  newHeading.trueHeading * M_PI / 180.0f;
    float managerheadRad = manager.heading.trueHeading * M_PI/180.0f;
    float newHeadingRad = newHeading.trueHeading * M_PI /180.0f;
    float angleCalc;
    if (newHeading.magneticHeading > VenueBearDeg)
    {angleCalc = -(newHeading.magneticHeading - VenueBearDeg);
    }
    else
    { angleCalc = VenueBearDeg - newHeading.magneticHeading;
        
    }
    //float angleCalc = (VenueBearDeg - newHeading.magneticHeading);
  
    NSLog(@"%@", self.nearestPlaceLabel.text);
    float radAngleCalc = angleCalc * M_PI / 180.0f;
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //theAnimation.fromValue = [NSNumber numberWithFloat:0];
    //theAnimation.toValue=[NSNumber numberWithFloat:radAngleCalc];
    theAnimation.duration = .5f;
    [self.saiImage.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
    
    //float currentPointerDeg =
    
    self.saiImage.transform = CGAffineTransformMakeRotation(radAngleCalc);
     self.nearestPlaceLabel.text = nearPlaceName;
    
    //CLLocation * remainingDist =
    //	//NSLog(@"%f (%f) => %f (%f)", manager.heading.trueHeading, oldRad, newHeading.trueHeading, newRad);
    //    //NSLog(@"%f true heading (%f oldRadian) => %f newHeading (%f) newRadian", manager.heading.trueHeading, oldRadian, newHeading.trueHeading, newRadian);
    
    
    NSLog(@"magnetic heading now is %f", newHeading.magneticHeading);
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationUpdated)
                                                 name:@"locationUpdated"
                                               object:nil];
    NSLog(@"We're subscribed.");
    // NSLog(@"%@", appDelegate.theItems);
    
    
    if (appDelegate.location) {
        [self locationUpdated];
        NSLog(@"Already had the location.");
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"locationUpdated" object:nil];
}

- (void)locationUpdated {
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [self locationManager:nil didUpdateLocations:[NSArray arrayWithObject:appDelegate.location]];


}

- (IBAction)try:(id)sender {
    
    //AppDelegate
    
//      AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    NSLog(@"%@", appDelegate.theItems);
//    NSLog(@"%@", appDelegate.closestVenue);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
