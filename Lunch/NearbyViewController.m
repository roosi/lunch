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
    [super viewDidLoad];
    self.nearbyManager = [RestaurantNearbyManager sharedManager];
    
    [self.nearbyManager addObserver:self forKeyPath:@"nearbyRestaurants" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@", keyPath);
    if ([keyPath isEqualToString:@"nearbyRestaurants"])
    {
        [self.tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"");
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
    return [self.nearbyManager countOfNearbyRestaurants];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NearbyRestaurantCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Restaurant *restaurant = [self.nearbyManager objectInNearbyRestaurantsAtIndex:indexPath.row];
    
    cell.textLabel.text = restaurant.name;
    
    return cell;
}
@end
