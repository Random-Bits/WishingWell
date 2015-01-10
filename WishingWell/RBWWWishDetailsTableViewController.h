//
//  RBWWWishDetailsTableViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 13/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBWWWish;
@class RBWWWishDetailsTableViewController;

@protocol RBWWDetailsTableViewControllerDelegate <NSObject>

- (void)setRightBarButtonItemStateEnabled:(BOOL)enebled;
- (void)dismissWishDetailsController:(RBWWWishDetailsTableViewController *)controller;
@end

@interface RBWWWishDetailsTableViewController : UITableViewController
@property (nonatomic,strong) RBWWWish *wish;
@property (nonatomic, weak) id<RBWWDetailsTableViewControllerDelegate> delegate;

-(void)saveWish;
@end
