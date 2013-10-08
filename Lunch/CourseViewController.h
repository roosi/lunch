//
//  CourseViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/7/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Course;
@class LunchDataController;

@interface CourseViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) Course *course;
@property (weak, nonatomic) LunchDataController *dataController;
@property (nonatomic) NSUInteger index;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)pageChanged:(id)sender;

@end
