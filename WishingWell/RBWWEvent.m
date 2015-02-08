//
//  RBWWEvent.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 15/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWEvent.h"
#import <Parse/PFObject+Subclass.h>

@implementation RBWWEvent
+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"RBWWEvent";
}

-(BOOL)isValidForUpdate {
    if (!self.eventDescr) {
        return NO;
    }
    if (!self.eventDate) {
        return  NO;
    }
    if (!self.eventOwner) {
        return NO;
    }
    return YES;
}

@dynamic eventDescr;
@dynamic eventDate;
@dynamic eventOwner;
@end
