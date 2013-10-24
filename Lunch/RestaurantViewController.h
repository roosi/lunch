//
//  RestaurantViewController.h
//  Lunch
//
//  Created by Jouni Nurmi on 23/10/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Restaurant;

@interface RestaurantViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic) Restaurant *restaurant;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
