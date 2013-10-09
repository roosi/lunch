//
//  RestaurantDataController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Restaurant;

@interface RestaurantDataController : NSObject
@property (nonatomic, copy) NSMutableArray *restaurants;

+(RestaurantDataController *) sharedController;

-(NSUInteger) countOfRestaurants;
-(Restaurant *) objectInRestaurantsAtIndex:(NSUInteger)index;
-(void) retrieveRestaurants: (void(^)())callback;
@end
