//
//  Course.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *properties;
@property (nonatomic,copy) NSString *titleFi;
@property (nonatomic,copy) NSString *titleEn;

-(id)initWithJson:(NSDictionary *)json;
@end
