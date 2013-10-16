//
//  RestaurantDataController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "RestaurantDataController.h"
#import "Restaurant.h"
#import <CoreLocation/CoreLocation.h>

@implementation RestaurantDataController

static RestaurantDataController *instance;

+(RestaurantDataController *) sharedController
{
    if (instance == nil)
    {
        instance = [[RestaurantDataController alloc] init];
    }
    return instance;
}

-(id) init
{
    if (self = [super init])
    {
        self.restaurants = [[NSMutableArray alloc] init];

        [self.restaurants addObject:[[Restaurant alloc] initWithId:429 name:@"Jyväskylän poliisi- ja oikeustalo" location:CLLocationCoordinate2DMake(62.242598, 25.752531)]];
        [self.restaurants addObject:[[Restaurant alloc] initWithId:444 name:@"Mattilanniemi, Jyväskylä" location:CLLocationCoordinate2DMake(62.233205, 25.738800)]];
        [self.restaurants addObject:[[Restaurant alloc] initWithId:485 name:@"Tietotalo, Jyväskylä" location:CLLocationCoordinate2DMake(62.239606, 25.749208)]];
        
        return self;
    }
    return nil;
}

-(void) retrieveRestaurants:(void (^)())callback {
    
    //TODO
    
    if (callback)
    {
        callback();
    }

}

-(void) setRestaurants:(NSMutableArray *)restaurants
{
    if (_restaurants != restaurants) {
        _restaurants = [restaurants mutableCopy];
    }
}

-(NSUInteger) countOfRestaurants
{
    return [self.restaurants count];
}

-(Restaurant *) objectInRestaurantsAtIndex:(NSUInteger)index
{
    return [self.restaurants objectAtIndex:index];
}

-(NSUInteger) selectedRestaurant {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger index = [defaults integerForKey:@"SelectedRestaurant"];
    return index;
}

-(void) setSelectedRestaurant:(NSUInteger)selectedRestaurant {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selectedRestaurant forKey:@"SelectedRestaurant"];
    [defaults synchronize];
}


@end
