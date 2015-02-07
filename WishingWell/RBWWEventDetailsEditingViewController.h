//
//  RBWWEventDetailsEditingViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 6/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  RBWWEvent;
@class RBWWEventDetailsEditingViewController;
@class RBWWEventDetailsTableViewController;

@protocol RBWWEventEditorDelegate <NSObject>
- (void)controller:(RBWWEventDetailsEditingViewController *)controller
didfinishEditingEvent:(RBWWEvent *)event
      withSaveFlag:(BOOL)saveFlag
        forNewWish:(BOOL)isNew;
@end

@interface RBWWEventDetailsEditingViewController : UIViewController
@property (nonatomic,strong) RBWWEventDetailsTableViewController *eventDetails;
@property (nonatomic,strong) RBWWEvent *eventForEditing;
@property(nonatomic, weak) id<RBWWEventEditorDelegate> delegate;
@end

@interface RBWWEventDetailsEditingViewController (Private)

@end
