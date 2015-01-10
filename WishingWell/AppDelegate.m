//
//  AppDelegate.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 8/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // ****************************************************************************
    // Parse initialization
    [Parse setApplicationId:@"n3ID7ir7lkpIPhFpcEkVkQEKnadVkMtW81PlwuKS"
                  clientKey:@"AQWaWPhru85EhKwXHWpZGgfjMfIUhMuiA42z5K3O"];
    // ****************************************************************************
    

    return YES;
}


@end
