//
//  RBWWUserProfileTableViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 5/03/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBWWProfile.h"
@class RBWWUserProfileTableViewController;

@protocol RBWWUserProfileEditorDelegate <NSObject>

-(void)profileEditor:(RBWWUserProfileTableViewController *)editor didSetPhoto:(UIImage *)newPhoto;

@end
@interface RBWWUserProfileTableViewController : UITableViewController
@property (nonatomic,strong) RBWWProfile *profile;
@property (nonatomic,strong) id<RBWWUserProfileEditorDelegate> delegate;
@end
