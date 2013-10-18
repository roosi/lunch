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
#import "RestaurantNearbyManager.h"

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL nearbyReminder = [defaults boolForKey:@"NearbyReminderSwitch"];
    self.nearbyReminderSwitch.on = nearbyReminder;
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

-(void)locationPickerController:(LocationPickerController *)picker didFinishPickingLocation:(Restaurant *)restaurant
{
    /*
    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:restaurant.coordinate radius:500.0 identifier: [NSString stringWithFormat:@"%i", restaurant.id]];
    
    for (CLRegion * monitored in [self.locationManager monitoredRegions])
    {
        [self.locationManager stopMonitoringForRegion:monitored];
    }
    [self.locationManager startMonitoringForRegion:region];
     */

    self.locationLabel.text = restaurant.name;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)locationPickerControllerDidCancel:(LocationPickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, region.description);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, region.description);
}

- (IBAction)nearbyReminderChanged:(id)sender {
    UISwitch *nearbyReminder = sender;
    NSLog(@"nearbyReminderChanged %i", nearbyReminder.on);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL currentValue = [defaults boolForKey:@"NearbyReminderSwitch"];

    if (currentValue != nearbyReminder.on || [defaults objectForKey:@"NearbyReminderSwitch"] == nil) {
        if (nearbyReminder.on) {
            [[RestaurantNearbyManager sharedManager] startMonitoring];
        }
        else {
            [[RestaurantNearbyManager sharedManager] stopMonitoring];
        }
    }

    [defaults setBool:nearbyReminder.on forKey:@"NearbyReminderSwitch"];
    [defaults synchronize];
}
@end
