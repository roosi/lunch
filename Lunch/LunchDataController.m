//
//  LunchDataController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LunchDataController.h"
#import "Course.h"
#import "Restaurant.h"

@interface LunchDataController ()
@end

@implementation LunchDataController

static LunchDataController* instance;

+(LunchDataController *) sharedController
{
    if (instance == nil) {
        instance = [[LunchDataController alloc] init];
    }
    return instance;
}

-(id)init {
    if (self = [super init]) {
        self.courses = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

-(void)setDate:(NSDate *)date
{
    NSLog(@"%@", date);
    if (_date != date) {
        _date = date;
        if (_restaurant != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
                [self retrieveLunchWithDate:_date restaurant: _restaurant success:^{
                    _error = nil;
                } failure:^(NSError *error) {
                    self.error = error;
                }];
            });
        }
    }
}

-(void)setCourses:(NSMutableArray *)courses {
    if(_courses != courses) {
        _courses = [courses mutableCopy];
    }
}

-(NSUInteger)countOfCourses {
    return [self.courses count];
}

-(Course *)objectInCoursesAtIndex:(NSUInteger)index {
    return [self.courses objectAtIndex:index];
}

// KVC
-(void) insertObject:(Course *)object inCoursesAtIndex:(NSUInteger)index
{
    [self.courses insertObject:object atIndex:index];
}

-(void) removeObjectFromCoursesAtIndex:(NSUInteger)index
{
    [self.courses removeObjectAtIndex:index];
}

-(void) retrieveLunchWithDate:(NSDate *)date restaurant:(Restaurant *)restaurant success: (void(^)())success failure: (void(^)(NSError *error)) failure
{
    //http://www.sodexo.fi/ruokalistat/output/daily_json/444/2013/10/2/fi
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSString *urlString = [NSString stringWithFormat:@"http://www.sodexo.fi/ruokalistat/output/daily_json/%iu/%ld/%ld/%ld/fi", restaurant.id, (long)components.year,(long)components.month,(long)components.day];
    
    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *error) {
        
        if(!error) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
            //NSLog(@"JSON: %@", jsonDict);
            NSArray *courses = [jsonDict objectForKey:@"courses"];
            
            //TODO auto?
            [self willChangeValueForKey:@"courses"];
            [self.courses removeAllObjects];
            [self didChangeValueForKey:@"courses"];
            
            for(id object in courses) {
                Course *course = [[Course alloc] initWithJson:object];
                [self insertObject:course inCoursesAtIndex:[self countOfCourses]];
            }
            
            if (success) {
                success();
            }
        }
        else {
            //NSLog(@"\nJSON: %@ \n Error: %@", data, error);
            if (failure) {
                failure(error);
            }
        }
        
    }];
}

@end
