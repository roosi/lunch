//
//  Restaurant.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Restaurant : NSObject
@property (nonatomic) NSUInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id) initWithId:(int)id name:(NSString *) name;
-(id) initWithId:(int)id name:(NSString *) name location:(CLLocationCoordinate2D)coordinate;
@end
