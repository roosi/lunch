//
//  LocationViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 10/9/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RestaurantDataController;
@class Restaurant;
@protocol LocationPickerControllerDelegate;

@interface LocationPickerController : UIViewController <UITableViewDelegate, UITableViewDelegate>

@property (nonatomic, assign) id<LocationPickerControllerDelegate> delegate;

@property (nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) RestaurantDataController *dataController;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;

@end

@protocol LocationPickerControllerDelegate <NSObject>

// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.
- (void)locationPickerController:(LocationPickerController *)picker didFinishPickingLocation:(Restaurant *)location;
- (void)locationPickerControllerDidCancel:(LocationPickerController *)picker;

@end