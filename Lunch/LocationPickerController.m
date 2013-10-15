//
//  LocationViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LocationPickerController.h"
#import "Restaurant.h"
#import "RestaurantDataController.h"

@interface LocationPickerController ()

@end

@implementation LocationPickerController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataController = [RestaurantDataController sharedController];
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    // Return the number of rows in the section.
    return [self.dataController countOfRestaurants];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");    
    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.dataController objectInRestaurantsAtIndex:indexPath.row] name];
    
    if (self.selectedIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectedIndex == indexPath.row) {
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndex = indexPath.row;
    }
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (IBAction)cancelTapped:(id)sender
{
    [self.delegate locationPickerControllerDidCancel:self];
}

- (IBAction)doneTapped:(id)sender
{
    [self.dataController setSelectedRestaurant:self.selectedIndex];
    Restaurant * restaurant = [self.dataController objectInRestaurantsAtIndex:self.selectedIndex];
    [self.delegate locationPickerController:self didFinishPickingLocation:restaurant];
}
@end
