//
//  LunchAppDelegate.m
//  Lunch
//
//  Created by Jouni Nurmi on 10/2/13.
//  Copyright (c) 2013 Jouni Nurmi. All rights reserved.
//

#import "LunchAppDelegate.h"
#import "RestaurantNearbyManager.h"
#import "Settings.h"

@interface LunchAppDelegate ()
{
    BOOL isAppResumingFromBackground;
}

@end
@implementation LunchAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"didFinishLaunchingWithOptions %@", launchOptions.description);
    
    UILocalNotification *notification = [launchOptions objectForKey:(UIApplicationLaunchOptionsLocalNotificationKey)];
    if (notification) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:notification.alertBody message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        application.applicationIconBadgeNumber = 0;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:NearbyReminderSwitch]) {
        [[RestaurantNearbyManager sharedManager] startMonitoring];
    }

    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //NSLog(@"didReceiveLocalNotification %@", notification.alertBody);
    UIApplicationState state = [application applicationState];
    //NSLog(@"didReceiveLocalNotification %i %i", state, isAppResumingFromBackground);
    
    if (state == UIApplicationStateActive || isAppResumingFromBackground) {
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        if (isAppResumingFromBackground) {
            [tabBarController setSelectedIndex:1];
        }
    }
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    isAppResumingFromBackground = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
