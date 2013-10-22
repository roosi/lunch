//
//  RestaurantNearbyManager.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/18/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "RestaurantNearbyManager.h"
#import "RestaurantDataController.h"
#import "Restaurant.h"

@interface RestaurantNearbyManager ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation RestaurantNearbyManager

NSString * const RestaurantMovingAwayNotification = @"RestaurantMovingAwayNotification";
NSString * const RestaurantClosingNotification = @"RestaurantClosingNotification";

static RestaurantNearbyManager* instance;

+ (RestaurantNearbyManager *) sharedManager
{
    if (instance == nil) {
        instance = [[RestaurantNearbyManager alloc] init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.nearbyRestaurants = [[NSMutableArray alloc] init];
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    [self.nearbyRestaurants removeAllObjects];
    
    NSArray *restaurants = [[RestaurantDataController sharedController] restaurants];
    for (Restaurant *restaurant in restaurants) {
        CLLocation *restaurantLocation = [[CLLocation alloc] initWithLatitude:restaurant.coordinate.latitude longitude:restaurant.coordinate.longitude];
        CLLocationDistance distance = [location distanceFromLocation:restaurantLocation];
        if (distance < 500)
        {
            [self.nearbyRestaurants addObject:restaurant];
        }
    }
}

- (void) startMonitoring
{
    NSArray *restaurants = [[RestaurantDataController sharedController] restaurants];
    for (Restaurant *restaurant in restaurants) {
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:restaurant.coordinate radius:500.0 identifier: [NSString stringWithFormat:@"%i", restaurant.id]];
        [self.locationManager startMonitoringForRegion:region];
    }
}

- (void) stopMonitoring
{
    for (CLRegion * monitored in [self.locationManager monitoredRegions])
    {
        [self.locationManager stopMonitoringForRegion:monitored];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    Restaurant *restaurant = [[RestaurantDataController sharedController] objectInRestaurantsWithId:region.identifier.intValue];
    NSLog(@"%@", restaurant.name);
    
    [self insertObject:restaurant inNearbyRestaurantsAtIndex:[self countOfNearbyRestaurants]];

    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.name, @"Restaurant", nil];
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate date];
    localNotification.alertBody = [NSString stringWithFormat:@"%@ is nearby.", restaurant.name];
    localNotification.alertAction = nil;
    localNotification.hasAction = YES;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.userInfo = userInfo;
    
    int current = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: current + 1];
                   
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    NSLog(@"Send %@", RestaurantMovingAwayNotification);
    [[NSNotificationCenter defaultCenter] postNotificationName:RestaurantClosingNotification object:self userInfo:userInfo];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    Restaurant *restaurant = [[RestaurantDataController sharedController] objectInRestaurantsWithId:region.identifier.intValue];
    NSLog(@"%@", restaurant.name);
    
    
    [self removeObjectFromNearbyRestaurantsAtIndex:[self.nearbyRestaurants indexOfObject:restaurant]];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.name, @"Restaurant", nil];
    
    int current = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    if (current > 0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: current - 1];
    }
    
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notication in notifications) {
        if ([[notication.userInfo valueForKey:@"Restaurant"] isEqual:restaurant.name]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notication];
            break;
        }
    }
    
    NSLog(@"Send %@", RestaurantMovingAwayNotification);
    [[NSNotificationCenter defaultCenter] postNotificationName:RestaurantMovingAwayNotification object:self userInfo:userInfo];
}

- (void) setNearbyRestaurants:(NSMutableArray *)nearbyRestaurants
{
    if (_nearbyRestaurants != nearbyRestaurants) {
        _nearbyRestaurants = [nearbyRestaurants mutableCopy];
    }
}

- (NSUInteger) countOfNearbyRestaurants
{
    return [self.nearbyRestaurants count];
}

- (Restaurant *) objectInNearbyRestaurantsAtIndex:(NSUInteger)index
{
    return [self.nearbyRestaurants objectAtIndex:index];
}

- (void) insertObject:(Restaurant *)object inNearbyRestaurantsAtIndex:(NSUInteger)index
{
    [self.nearbyRestaurants insertObject:object atIndex:index];
}

- (void) removeObjectFromNearbyRestaurantsAtIndex:(NSUInteger)index
{
    [self.nearbyRestaurants removeObjectAtIndex:index];
}
@end
