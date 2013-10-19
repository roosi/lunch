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
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    }
    return self;
}

- (void) startMonitoring
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSArray *restaurants = [[RestaurantDataController sharedController] restaurants];
    for (Restaurant *restaurant in restaurants) {
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:restaurant.coordinate radius:500.0 identifier: [NSString stringWithFormat:@"%i", restaurant.id]];
        [self.locationManager startMonitoringForRegion:region];
    }
}

- (void) stopMonitoring
{
    NSLog(@"%s", __PRETTY_FUNCTION__);    
    for (CLRegion * monitored in [self.locationManager monitoredRegions])
    {
        [self.locationManager stopMonitoringForRegion:monitored];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    Restaurant *restaurant = [[RestaurantDataController sharedController] objectInRestaurantsWithId:region.identifier.intValue];
    NSLog(@"%s %@", __PRETTY_FUNCTION__, restaurant.name);

    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate date];
    localNotification.alertBody = [NSString stringWithFormat:@"%@ is nearby.", restaurant.name];
    localNotification.alertAction = nil;
    localNotification.hasAction = YES;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.name, @"Restaurant", nil];
    
    int current = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: current + 1];
                   
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    Restaurant *restaurant = [[RestaurantDataController sharedController] objectInRestaurantsWithId:region.identifier.intValue];
    NSLog(@"%s %@", __PRETTY_FUNCTION__, restaurant.name);
    
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
}

@end
