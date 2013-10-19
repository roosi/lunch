//
//  RestaurantNearbyManager.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/18/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RestaurantNearbyManager : NSObject <CLLocationManagerDelegate>
extern NSString * const RestaurantMovingAwayNotification;
extern NSString * const RestaurantClosingNotification;

+ (RestaurantNearbyManager *) sharedManager;
- (void) startMonitoring;
- (void) stopMonitoring;
@end