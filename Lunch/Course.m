//
//  Course.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "Course.h"

@implementation Course

-(id)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self) {
        _category = [json objectForKey:@"category"];
        _price = [json objectForKey:@"price"];
        _properties = [json objectForKey:@"properties"];
        _titleEn = [json objectForKey:@"title_en"];
        _titleFi = [json objectForKey:@"title_fi"];
        return self;
    }
    return nil;
}

@end
