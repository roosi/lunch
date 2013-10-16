//
//  SettingsViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/14/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationPickerController.h"
#import <CoreLocation/CoreLocation.h>

@interface SettingsViewController : UITableViewController <LocationPickerControllerDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
