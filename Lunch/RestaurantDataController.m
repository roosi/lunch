//
//  RestaurantDataController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "RestaurantDataController.h"
#import "Restaurant.h"

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
        
        [self.restaurants addObject:[[Restaurant alloc] initWithId:429 name:@"Jyväskylän poliisi- ja oikeustalo"]];
        [self.restaurants addObject:[[Restaurant alloc] initWithId:444 name:@"Mattilanniemi, Jyväskylä"]];
        [self.restaurants addObject:[[Restaurant alloc] initWithId:485 name:@"Tietotalo, Jyväskylä"]];
        
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

@end
