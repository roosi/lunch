//
//  CoursePage.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/8/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "CoursePage.h"
#import "Course.h"

@implementation CoursePage

+ (id)initWithCourse:(Course *) course
{
    CoursePage *coursePage = [[[NSBundle mainBundle] loadNibNamed:@"CoursePage" owner:nil options:nil] lastObject];
    if ([coursePage isKindOfClass:[CoursePage class]]) {
        [coursePage setCourse:course];
        return coursePage;
    }
    else {
        return nil;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setCourse:(Course *)course
{
    if (_course != course) {
        _course = course;
    }
    NSLocale *locale = [NSLocale currentLocale];
    NSString *title = self.course.titleFi;
    if ([locale.localeIdentifier isEqual:@"fi_FI"]) {
        title = self.course.titleFi;
    }
    else if ([locale.localeIdentifier isEqual:@"en_US"]) {
        title = self.course.titleEn;
    }
    
    if (title == nil) {
        title = self.course.titleFi;
    }
    self.nameLabel.text = title;
    
    self.priceLabel.text = _course.price;
    self.propertiesLabel.text = _course.properties;
    if ([course.category isEqual:@"Scandinavian"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"114.png"];
    }
    else if ([course.category isEqual:@"Global"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"58.png"];
    }
    else if ([course.category isEqual:@"Vegetarian"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"26.png"];
    }
    else if ([course.category isEqual:@"Salad garden & Soup"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"136.png"];
    }
    else if ([course.category isEqual:@"Sweet"]) {
        self.categoryImageView.image = [UIImage imageNamed:@"146.png"];
    }
    else {
        self.categoryImageView.image = [UIImage imageNamed:@"142.png"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
