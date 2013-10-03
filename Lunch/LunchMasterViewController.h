//
//  LunchMasterViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LunchDataController;

@interface LunchMasterViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender;
@property (strong, nonatomic) LunchDataController *dataController;
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;
@end
