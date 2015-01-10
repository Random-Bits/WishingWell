//
//  RBWWUserDataTabBarController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 2/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBWWUserDataTabBarController;

@protocol RBWWUserDataTabBarControllerDelegate <NSObject>

-(void)performUserLogoutWithController:(RBWWUserDataTabBarController *)userDataController;

@end

@interface RBWWUserDataTabBarController : UITabBarController
@property (nonatomic, weak) id<RBWWUserDataTabBarControllerDelegate> userDataDelegate;
@end
