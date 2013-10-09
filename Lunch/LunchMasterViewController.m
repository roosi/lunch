//
//  LunchMasterViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LunchMasterViewController.h"

#import "LunchDetailViewController.h"

#import "LunchDataController.h"
#import "Course.h"

@interface LunchMasterViewController () {
    NSDate *dateShown;
}
@end

@implementation LunchMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    dateShown = [NSDate date];
    
    self.dataController = [LunchDataController sharedController];

    self.todayButton.target = self;
    self.todayButton.action = @selector(goToday:);
    
    [self retrieveLunch:dateShown];
}

- (void)goToday:(id)sender
{
    [self retrieveLunch:[NSDate date]];
}

- (void)retrieveLunch:(NSDate *)date
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator startAnimating];

    dateShown = date;
    
    NSDateComponents *componentsDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:dateShown];
    NSDateComponents *componentsToday = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    self.todayButton.enabled = YES;
    
    if (componentsDate.year == componentsToday.year &&
        componentsDate.month == componentsToday.month) {
        if (componentsDate.day == componentsToday.day) {
            self.title = @"Today";
            self.todayButton.enabled = NO;
        }
        else if (componentsDate.day + 1 == componentsToday.day) {
            self.title = @"Yesterday";
        }
        else if (componentsDate.day - 1 == componentsToday.day) {
            self.title = @"Tomorrow";
        }
        else {
            NSDateFormatter *formatter = nil;
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterShortStyle];
            [self setTitle:[formatter stringFromDate:dateShown]];
        }
    }
    else {
        self.title = dateShown.description;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [self.dataController retrieveLunchWithDate:dateShown completion: ^{
            NSLog(@"Completed");
            [self lunchRetrived];
        }];
    });
}

- (void)lunchRetrived
{
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
    activityIndicator = [[UIActivityIndicatorView alloc]init];
    activityIndicator.center = self.tableView.center;
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setColor:[UIColor blackColor]];
    [self.tableView addSubview:activityIndicator];
    [activityIndicator startAnimating];
     */

}
   
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = [self.dataController countOfCourses];
    NSLog(@"numberOfRowsInSection %ld", (long)count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath %ld", (long)indexPath.row);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Course *course = [self.dataController objectInCoursesAtIndex:indexPath.row];
    cell.textLabel.text = course.titleEn;
    if ([course.category isEqual:@"Scandinavian"]) {
        cell.imageView.image = [UIImage imageNamed:@"114.png"];
    }
    else if ([course.category isEqual:@"Global"]) {
        cell.imageView.image = [UIImage imageNamed:@"58.png"];
    }
    else if ([course.category isEqual:@"Vegetarian"]) {
        cell.imageView.image = [UIImage imageNamed:@"26.png"];
    }
    else if ([course.category isEqual:@"Salad garden & Soup"]) {
        cell.imageView.image = [UIImage imageNamed:@"136.png"];
    }
    else if ([course.category isEqual:@"Sweet"]) {
        cell.imageView.image = [UIImage imageNamed:@"146.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"142.png"];
    }

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowCourse"]) {
        NSLog(@"ShowCourse");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        [[segue destinationViewController] setIndex:indexPath.row];
    }
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipeRigth");
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    
    dateShown = [gregorian dateByAddingComponents:components toDate:dateShown options:0];
    
    [self retrieveLunch:dateShown];
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipeLeft");
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    
    dateShown = [gregorian dateByAddingComponents:components toDate:dateShown options:0];
    
    [self retrieveLunch:dateShown];
}
@end
