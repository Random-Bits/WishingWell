//
//  RBWWMyWishesTableViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 9/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import "RBWWProfile.h"

@class RBWWMyWishesTableViewController;

@interface RBWWMyWishesTableViewController : PFQueryTableViewController
@property (nonatomic,weak) RBWWProfile *profile;
@end
