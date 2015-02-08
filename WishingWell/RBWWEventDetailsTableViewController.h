//
//  RBWWEventDetailsTableViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 5/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBWWEvent;
@class RBWWEventDetailsTableViewController;

@protocol RBWWEventDetailsTableViewControllerDelegate <NSObject>

- (void)setRightBarButtonItemStateEnabled:(BOOL)enebled;
- (void)dismissEventDetailsController:(RBWWEventDetailsTableViewController *)controller;
@end

@interface RBWWEventDetailsTableViewController : UITableViewController
@property (nonatomic,strong) RBWWEvent *event;
@property (nonatomic, weak) id<RBWWEventDetailsTableViewControllerDelegate> delegate;

-(void)saveEvent;
@end

