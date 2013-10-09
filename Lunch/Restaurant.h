//
//  Restaurant.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
@property (nonatomic) NSUInteger id;
@property (nonatomic, copy) NSString *name;

-(id) initWithId:(int)id name:(NSString *) name;
@end
