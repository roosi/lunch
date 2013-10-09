//
//  Restaurant.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

-(id) initWithId:(int)id name:(NSString *)name
{
    self = [super init];
    if (self) {
        _id = id;
        _name = name;
        return self;
    }
    return nil;
}
@end
