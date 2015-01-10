//
//  RBWWUserProfileController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 2/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBWWUserProfileController;

@protocol RBWWUserProfileControllerDelegate <NSObject>

-(void)performLogoutWithUserProfileController:(RBWWUserProfileController *)profileController;

@end
@interface RBWWUserProfileController : UIViewController
@property (nonatomic, weak) id<RBWWUserProfileControllerDelegate> delegate;
@end
