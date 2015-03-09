//
//  RBWWWish.h
//  Wishing Well
//
//  Created by Anatoly Ermolaev on 8/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//


#import <Parse/Parse.h>
#import "RBWWProfile.h"

@interface RBWWWish : PFObject <PFSubclassing>
@property (retain) NSString *shortDescr;
@property (retain) NSString *priority;
@property (retain) RBWWProfile *ownersProfile;
+ (NSString *)parseClassName;
-(BOOL)validateForUpdate;
@end