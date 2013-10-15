//
//  SettingsViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/14/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "SettingsViewController.h"
#import "LocationPickerController.h"
#import "RestaurantDataController.h"
#import "Restaurant.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

    NSUInteger index = [[RestaurantDataController sharedController] selectedRestaurant];
    self.locationLabel.text = [[RestaurantDataController sharedController] objectInRestaurantsAtIndex:index].name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SelectLocation"]) {
        LocationPickerController *destinationViewController = [segue destinationViewController];
        destinationViewController.delegate = self;
    }
}

-(void)locationPickerController:(LocationPickerController *)picker didFinishPickingLocation:(Restaurant *)location
{
    self.locationLabel.text = location.name;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)locationPickerControllerDidCancel:(LocationPickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
