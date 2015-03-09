//
//  RBWWEventsTableViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 27/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import "RBWWProfile.h"

@interface RBWWEventsTableViewController : PFQueryTableViewController
@property(nonatomic,strong) RBWWProfile *profile;
@end
