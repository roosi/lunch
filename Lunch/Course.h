//
//  Course.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject
@property (nonatomic,readonly) NSString *category;
@property (nonatomic,readonly) NSString *price;
@property (nonatomic,readonly) NSString *properties;
@property (nonatomic,readonly) NSString *titleFi;
@property (nonatomic,readonly) NSString *titleEn;

-(id)initWithJson:(NSDictionary *)json;
@end
