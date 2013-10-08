//
//  CoursePage.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/8/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Course;

@interface CoursePage : UIView

@property (strong, nonatomic) Course *course;

+ (id) initWithCourse:(Course *) course;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *propertiesLabel;
@property (nonatomic, weak) IBOutlet UIImageView *categoryImageView;
@end
