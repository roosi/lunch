//
//  LunchDetailViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LunchDetailViewController.h"

#import "LunchDataController.h"
#import "Course.h"

@interface LunchDetailViewController ()
- (void)configureView;
@end

@implementation LunchDetailViewController

#pragma mark - Managing the detail item

- (void)setCourse:(id)newCourse
{
    NSLog(@"setCourse");
    if (_course != newCourse) {
        _course = newCourse;
        
        // Update the view.
        [self configureView];
    }
}

-(void) setIndex:(NSUInteger)index
{
    NSLog(@"setIndex %d", index);
    _index = index;
    self.course = [self.dataController objectInCoursesAtIndex:index];
    [self configureView];
}

- (void)configureView
{
    NSLog(@"configureView");
    // Update the user interface for the detail item.

    if (self.course) {
        [self setTitle:self.course.category];
        self.nameLabel.text = self.course.titleEn;
        self.categoryLabel.text = self.course.category;
        self.propertiesLabel.text = self.course.properties;
        self.priceLabel.text = self.course.price;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    int count = [self.dataController countOfCourses];
    if (self.index < count - 1) {
        [self setIndex:(self.index + 1)];
    }
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    if (self.index > 0) {
        [self setIndex:(self.index - 1)];
    }
}
@end
