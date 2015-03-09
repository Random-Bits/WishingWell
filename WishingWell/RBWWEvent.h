//
//  RBWWEvent.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 15/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <Parse/Parse.h>
#import "RBWWProfile.h"

@interface RBWWEvent : PFObject<PFSubclassing>
@property (retain) NSString *eventDescr;
@property (retain) NSDate *eventDate;
@property (retain) RBWWProfile *ownersProfile;
+ (NSString *)parseClassName;
-(BOOL)isValidForUpdate;

@end
