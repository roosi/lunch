//
//  NearbyViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/18/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "NearbyViewController.h"
#import "RestaurantNearbyManager.h"

@interface NearbyViewController ()

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
    
    self.tabBarController.selectedViewController.tabBarItem.badgeValue = nil;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
@end
