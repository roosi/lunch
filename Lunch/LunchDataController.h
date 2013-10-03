//
//  LunchDataController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Course;

@interface LunchDataController : NSObject
@property (nonatomic, copy) NSMutableArray *courses;

-(NSUInteger) countOfCourses;
-(Course *) objectInCoursesAtIndex:(NSUInteger)index;
-(void) retrieveLunchWithDate:(NSDate*)date completion: (void(^)())callback;
@end
