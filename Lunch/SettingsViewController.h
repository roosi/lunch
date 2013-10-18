//
//  SettingsViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/14/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationPickerController.h"

@interface SettingsViewController : UITableViewController <LocationPickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
- (IBAction)nearbyReminderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *nearbyReminderSwitch;

@end
