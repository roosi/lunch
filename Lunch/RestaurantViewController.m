//
//  RestaurantViewController.m
//  Lunch
//
//  Created by Jouni Nurmi on 23/10/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "RestaurantViewController.h"
#import "Restaurant.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = self.restaurant.coordinate;
    annotation.title = self.restaurant.name;
    //anny.subtitle = self.restaurant.address;
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion region;
    region.center = self.restaurant.coordinate;
    region.span.latitudeDelta = 0.03;
    region.span.longitudeDelta = 0.03;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView selectAnnotation:annotation animated:NO];
    
    self.mapView.showsUserLocation = YES;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *AnnotationViewID = @"annotationViewID";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    annotationView.canShowCallout = YES;
    annotationView.annotation = annotation;
    return annotationView;
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
