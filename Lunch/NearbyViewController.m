//
//  NearbyViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/18/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "NearbyViewController.h"
#import "Restaurant.h"
#import "RestaurantNearbyManager.h"

@interface NearbyViewController ()
@property (nonatomic, strong) RestaurantNearbyManager* nearbyManager;
@end

@implementation NearbyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%s", __PRETTY_FUNCTION__);     
    [super viewDidLoad];
    self.nearbyManager = [RestaurantNearbyManager sharedManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restaurantMovingAway:) name:RestaurantMovingAwayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restaurantClosing:) name:RestaurantClosingNotification object:nil];
}


- (void)restaurantMovingAway:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)restaurantClosing:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __PRETTY_FUNCTION__); 
    [super viewWillAppear:animated];

    UIViewController *viewController = [self.tabBarController.viewControllers objectAtIndex:1];
    viewController.tabBarItem.badgeValue = nil;
    
    [self.tabBarItem setBadgeValue:nil];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self.nearbyManager countOfNearbyRestaurants];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);  
    static NSString *CellIdentifier = @"NearbyRestaurantCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Restaurant *restaurant = [self.nearbyManager objectInNearbyRestaurantsAtIndex:indexPath.row];
    
    cell.textLabel.text = restaurant.name;
    
    return cell;
}
@end
