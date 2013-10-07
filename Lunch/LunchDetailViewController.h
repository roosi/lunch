//
//  LunchDetailViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LunchDataController;
@class Course;

@interface LunchDetailViewController : UITableViewController

@property (strong, nonatomic) Course *course;
@property (weak, nonatomic) LunchDataController *dataController;
@property (nonatomic) NSUInteger index;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender;
@end
