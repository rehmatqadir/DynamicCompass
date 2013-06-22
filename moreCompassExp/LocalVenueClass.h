//
//  LocalVenueClass.h
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalVenueClass : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSNumber *distance;



+ (LocalVenueClass *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress andDistance:(NSNumber *)distance;

@end
