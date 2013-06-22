//
//  LocalVenueClass.m
//  moreCompassExp
//
//  Created by MasterRyuX on 6/8/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import "LocalVenueClass.h"

@implementation LocalVenueClass

+ (LocalVenueClass *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress andDistance:(NSNumber *)distance
{
    
    LocalVenueClass *localVenueClass = [[LocalVenueClass alloc]init];
    localVenueClass.name = name;
    localVenueClass.streetAddress = streetAddress;
    localVenueClass.distance = distance;
    
    return localVenueClass;
    
}

@end
