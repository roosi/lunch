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
@property (nonatomic) NSUInteger selectedRestaurant;

+(RestaurantDataController *) sharedController;

-(NSUInteger) countOfRestaurants;
-(Restaurant *) objectInRestaurantsAtIndex:(NSUInteger)index;
-(Restaurant *) objectInRestaurantsWithId:(NSUInteger)id;
@end
