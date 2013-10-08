//
//  LunchDataController.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LunchDataController.h"
#import "Course.h"

@interface LunchDataController ()
@end

@implementation LunchDataController
-(id)init {
    if (self = [super init]) {
        self.courses = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

-(void) retrieveLunchWithDate:(NSDate*)date completion: (void(^)())callback {
    NSLog(@"retrieveLunchWithDate");

    //http://www.sodexo.fi/ruokalistat/output/daily_json/444/2013/10/2/fi
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSString *urlString = [NSString stringWithFormat:@"http://www.sodexo.fi/ruokalistat/output/daily_json/444/%ld/%ld/%ld/fi", (long)components.year,(long)components.month,(long)components.day];

    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *error) {

        if(!error) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            NSLog(@"JSON: %@", jsonDict);
            NSArray *courses = [jsonDict objectForKey:@"courses"];
        
            [self.courses removeAllObjects];
            for(id object in courses) {
                Course *course = [[Course alloc] initWithJson:object];
                [self.courses addObject:course];
            }
        
            if (callback) {
                callback();
            }
        }
        else {
            NSLog(@"\nJSON: %@ \n Error: %@", data, error);
        }
        
    }];
    /*
    NSError *error = nil;
    NSString *json = [NSString stringWithContentsOfURL:url
                                              encoding:NSASCIIStringEncoding
                                                 error:&error];
                             
    if(!error) {
        NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions
                                                                   error:&error];
        NSLog(@"JSON: %@", jsonDict);
        NSArray *courses = [jsonDict objectForKey:@"courses"];
        
        [self.courses removeAllObjects];
        for(id object in courses) {
            Course *course = [[Course alloc] initWithJson:object];
            [self.courses addObject:course];
        }
        
        if (callback) {
            callback();
        }
    }
    else {
        NSLog(@"\nJSON: %@ \n Error: %@", json, error);
        
    }
     */
    
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
@end
