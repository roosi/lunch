//
//  LunchDataController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Course;
@class Restaurant;

@interface LunchDataController : NSObject
@property (nonatomic, copy) NSMutableArray *courses;
@property (nonatomic) NSDate *date;
@property (nonatomic) Restaurant *restaurant;
@property (nonatomic) NSError *error;

+(LunchDataController *) sharedController;

-(NSUInteger) countOfCourses;
-(Course *) objectInCoursesAtIndex:(NSUInteger)index;
-(void) retrieveLunchWithDate:(NSDate*)date restaurant:(Restaurant *)restaurant success:(void(^)()) success failure:(void(^)(NSError *error)) failure;
@end
