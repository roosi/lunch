//
//  LunchMasterViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LunchDataController;

@interface LunchViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) LunchDataController *dataController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *todayButton;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;
@end
