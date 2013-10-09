//
//  CourseViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/7/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "CourseViewController.h"

#import "LunchDataController.h"
#import "Course.h"
#import "CoursePage.h"

@interface CourseViewController ()
- (void)configureView;
@end

@implementation CourseViewController

-(void) setIndex:(NSUInteger)index
{
    NSLog(@"setIndex %d", index);
    _index = index;
    self.course = [self.dataController objectInCoursesAtIndex:index];
    [self configureView];
}

- (void)configureView
{
    NSLog(@"configureView %d", self.index);
    // Update the user interface for the detail item.
    
    if (self.course) {
        [self setTitle:self.course.category];
        [self.pageControl setCurrentPage:self.index];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataController = [LunchDataController sharedController];
}

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidload %d", [self.dataController countOfCourses]);
    for (int i = 0; i < [self.dataController countOfCourses]; i++) {
        Course *course = [self.dataController objectInCoursesAtIndex:i];
        
        CoursePage *coursePage = [CoursePage initWithCourse:course];

        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;

        [coursePage setFrame:frame];
        [self.scrollView addSubview:coursePage];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.dataController countOfCourses], self.scrollView.frame.size.height);
    
    [self.pageControl setNumberOfPages:[self.dataController countOfCourses]];
    [self setIndex:self.index];
    
    
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.index;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"scrollViewDidScroll");
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (self.index != page) {
        self.index = page;
    }
}

- (IBAction)pageChanged:(id)sender {
    NSLog(@"pageChanged %d", self.pageControl.currentPage);

    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
@end
