//
//  AppDelegate.m
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import "AppDelegate.h"
#import "VenueObject.h"
#import "LocalVenueClass.h"
#import "ViewController.h"

@interface AppDelegate()

{
    NSDictionary* firstDictionary;
    //NSArray* itemArray;
    NSDictionary *itemDictionary;
    NSMutableDictionary*
    listVenue;
    VenueObject* oneVenue;
    NSDictionary *categoryDictionary;
    NSMutableArray *categoryArray;
    NSMutableDictionary *categoryInfo;
    NSMutableDictionary * checkinStats;
    NSString *latitudeWithCurrentCoordinates;
    NSString *longitudeWithCurrentCoordinates;
    float ourFloatLat;
    float ourFloatLong;
    VenueObject *selectedVenue;

   NSMutableArray *arrayWithDistance;
    //NSArray *distanceSortedArray;
    
}


@property (nonatomic, strong) NSString * strLatitude;
@property (nonatomic, strong) NSString * strLongitude;
//@property (nonatomic, strong) NSMutableArray * restaurantList;

//-(void) nearestVenue;

@end
@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self startStandardLocationServices];
    // Override point for customization after application launch.
    return YES;
}

-(void) startStandardLocationServices
{
    if (nil == self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 500;
        
        [self.locationManager startUpdatingLocation];
        
        if([CLLocationManager headingAvailable]) {
            [self.locationManager startUpdatingHeading];
        } else {
            NSLog(@"No Compass -- You're lost");
        }
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = [locations objectAtIndex:0];
    
    
    CLLocation * ourlocation = [locations lastObject];
    NSDate* eventDate = ourlocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    //if (abs(howRecent) < 15.0) {
    
    // If the event is recent, do something with it.
    //NSLog(@"latitude %+.6f, longitude %+.6f\n", ourlocation.coordinate.latitude, ourlocation.coordinate.longitude);
    NSLog(@"this is from location manager: %f", ourlocation.coordinate.latitude);
    ourFloatLat = ourlocation.coordinate.latitude;
    ourFloatLong = ourlocation.coordinate.longitude;
    self.strLatitude = [NSString stringWithFormat: @"%f", ourlocation.coordinate.latitude];
    self.strLongitude = [NSString stringWithFormat: @"%f", ourlocation.coordinate.longitude];
    
    //[self StartStandardLocationServices];
    
    NSLog(@"this is from viewDidLoad");
 
    NSString *CurrentCoord = [NSString stringWithFormat:@"%@,%@", self.strLatitude, self.strLongitude];
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(ourFloatLat, ourFloatLong);
//    MKCoordinateSpan span = MKCoordinateSpanMake(.05, .05);
//    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);

    
    allItems1 = [[NSMutableArray alloc] init];
    self.theItems = [[NSMutableArray alloc] init];
    ViewController * VCData = [[ViewController alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@&query=sushi&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M", CurrentCoord];
    NSLog(@"The search URL is%@", urlString);
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error)
     
     {
         
         
         NSDictionary *bigDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         NSDictionary * venueDictionary = [bigDictionary objectForKey:@"response"];
         NSArray *groupsArray = [venueDictionary objectForKey:@"groups"];
         NSDictionary* subgroupDictionary = [groupsArray objectAtIndex:0];
         itemArray = [subgroupDictionary objectForKey:@"items"];
         

                  
         for (listVenue in itemArray)
             
         {
             oneVenue = [[VenueObject alloc]init] ;
             
             
             oneVenue.title = [listVenue objectForKey:@"name"];
             oneVenue.placeID = [listVenue objectForKey:@"id"];
             oneVenue.venueURL = listVenue [@"canonicalUrl"];
             oneVenue.placeLatitude = listVenue [@"location"][@"lat"];
             oneVenue.placeLongitude = listVenue [@"location"][@"lng"];
             oneVenue.coordinate = CLLocationCoordinate2DMake([oneVenue.placeLatitude floatValue], [oneVenue.placeLongitude floatValue]);
             if (listVenue [@"stats"][@"checkinsCount"] == nil || listVenue [@"stats"][@"checkinsCount"] == NULL)
             {
                 oneVenue.subtitle = @"0";
             } else {
                 NSString * subtitlecheckinPart = [listVenue[@"stats"][@"checkinsCount"] stringValue];
                 oneVenue.subtitle = [NSString stringWithFormat:@"%@ checkins", subtitlecheckinPart];
             }
             //NSLog(@"%@", oneVenue.subtitle);
             categoryArray = [listVenue objectForKey: @"categories"];
             
             
             if (categoryArray == nil || categoryArray == NULL || [categoryArray count] == 0)
                 
             {
                 oneVenue.venueCategory = @"Public Space";
             } else {
                 
                 categoryInfo = [categoryArray objectAtIndex:0];
                 oneVenue.venueCategory = [categoryInfo objectForKey:@"name"];
             }
             oneVenue.iconURL = [categoryInfo objectForKey: @"icon"];
             NSURL *NSiconURL = [NSURL URLWithString:oneVenue.iconURL];
             oneVenue.venueTypeIcon = [NSData dataWithContentsOfURL:NSiconURL];
             oneVenue.venueIcon = [[UIImage alloc] initWithData:oneVenue.venueTypeIcon];
             oneVenue.distance = listVenue[@"location"][@"distance"];
            // NSLog(@"%@", oneVenue.distance);
             [allItems1 addObject:oneVenue];
             [self.theItems addObject:oneVenue];
             [VCData.FUCKYOU addObject:oneVenue];
             //self.theItems = allItems1;
             //VCData.FUCKYOU = allItems1;
             
             
             
                     
             
         }
         
         [self sortArray];
              // VCData.FUCKYOU = allItems1;//NSLog(@"%@", self.theItems);//NSLog(@"%@", allItems1);
         //NSLog(@"%@",VCData.FUCKYOU);
     }];
   // [self sortArray];
    
   // VCData.FUCKYOU = allItems1;
    //VCData.FUCKYOU = self.theItems;
    //NSLog(@"%@",VCData.FUCKYOU);

}
//
//-(void) nearestVenue
//         {
//             
//             
//             arrayWithDistance =  [[NSMutableArray alloc]init];
//             
//             
//             for (NSDictionary *venueDictionary in itemArray) {
//                 
//                 
//                 NSString *name = [venueDictionary valueForKeyPath:@"name"];
//                 
//                 NSString *streetAddress = [venueDictionary valueForKeyPath:@"location.address"];
//                 
//                 NSNumber *distance = [venueDictionary valueForKeyPath:@"location.distance"];
//                 //NSString *fourSquareWebPage = [venueDictionary valueForKeyPath:@"canonicalUrl"];
//                 
//                 LocalVenueClass *localVenueClass = [LocalVenueClass LocalVenueObjectwithName:name andStreetAddress:streetAddress andDistance:distance];
//                 
//                 
//                 //LocalVenueClass *localVenue = [LocalVenueClass LocalVenueObjectwithName:name andStreetAddress:streetAddress Distance:distance]; //andFourSquareWebPage:fourSquareWebPage];
//                 
//                 [arrayWithDistance addObject:localVenueClass];
//                 
//                 
//             } //end of fast enum
//             
//             NSLog(@"%@ venuearraywithdistance", arrayWithDistance);
//             [self sortArray];
//             
//
//    
//}
//
-(void) sortArray {
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance"
                                                  ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *distanceSortedArray = [[NSArray alloc] init];
    distanceSortedArray = [self.theItems sortedArrayUsingDescriptors:sortDescriptors];
    
    self.closestVenue = [distanceSortedArray objectAtIndex:0];
//    NSLog(@"%@", self.theItems);
    NSLog(@"%@", distanceSortedArray);
    NSLog(@"%@", self.closestVenue);
    
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
