//
//  RBWWWishDetailsEditingController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 26/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  RBWWWish;
@class RBWWWishDetailsEditingController;
@class RBWWWishDetailsTableViewController;

@protocol RBWWWishEditorDelegate <NSObject>
- (void)controller:(RBWWWishDetailsEditingController *)controller
didfinishEditingWish:(RBWWWish *)wish
      withSaveFlag:(BOOL)saveFlag
        forNewWish:(BOOL)isNew;
@end

@interface RBWWWishDetailsEditingController : UIViewController
@property (nonatomic,strong) RBWWWishDetailsTableViewController *wishDetails;
@property (nonatomic,strong) RBWWWish *wishForEditing;
@property(nonatomic, weak) id<RBWWWishEditorDelegate> delegate;
@end

@interface RBWWWishDetailsEditingController (Private)

@end
