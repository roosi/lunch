//
//  LunchTabBarController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/19/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LunchTabBarController.h"
#import "RestaurantNearbyManager.h"

@interface LunchTabBarController ()

@end

@implementation LunchTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restaurantMovingAway:) name:RestaurantMovingAwayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restaurantClosing:) name:RestaurantClosingNotification object:nil];
}

- (void)restaurantMovingAway:(NSNotification *)notification {
    UITabBarItem *tabBarItem = [[self.viewControllers objectAtIndex:1] tabBarItem];
    int current = tabBarItem.badgeValue.intValue;
    current -= 1;
    if (current > 0) {
        tabBarItem.badgeValue = [NSString stringWithFormat:@"%i", current];
    }
    else {
        tabBarItem.badgeValue = nil;
    }
}

- (void)restaurantClosing:(NSNotification *)notification {
    UITabBarItem *tabBarItem = [[self.viewControllers objectAtIndex:1] tabBarItem];
    int current = tabBarItem.badgeValue.intValue;
    current += 1;
    tabBarItem.badgeValue = [NSString stringWithFormat:@"%i", current];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
