//
//  LocationViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RestaurantDataController;

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDelegate>

@property (nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) RestaurantDataController *dataController;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;

@end
