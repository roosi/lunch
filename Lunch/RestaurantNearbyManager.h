//
//  RestaurantNearbyManager.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/18/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Restaurant;

@interface RestaurantNearbyManager : NSObject <CLLocationManagerDelegate>
extern NSString * const RestaurantMovingAwayNotification;
extern NSString * const RestaurantClosingNotification;

@property (nonatomic, copy) NSMutableArray *nearbyRestaurants;

+ (RestaurantNearbyManager *) sharedManager;
- (void) startMonitoring;
- (void) stopMonitoring;
- (NSUInteger) countOfNearbyRestaurants;
- (Restaurant *) objectInNearbyRestaurantsAtIndex:(NSUInteger)index;
@end
