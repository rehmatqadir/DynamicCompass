//
//  VenueObject.h
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface VenueObject : NSObject<MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *placeID;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *placeLatitude;
@property (strong, nonatomic) NSString *placeLongitude;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *iconURL;
@property (strong, nonatomic) NSString *venueURL;
@property (strong, nonatomic) NSString *venueCategory;
@property (strong, nonatomic) UIImage *venueIcon;
@property (strong, nonatomic) UIImage *venueBigPic;
@property (strong, nonatomic) NSData *venueTypeIcon;
@property (strong, nonatomic) NSData *venuePic;
@property (strong, nonatomic) NSString*checkins;
@property(strong, nonatomic) NSString *rating;
@property(strong, nonatomic) NSString *hours;

@property(strong, nonatomic) NSString *additionalInfo;
@property(strong, nonatomic) NSMutableDictionary *hugeDictionary;


@end
