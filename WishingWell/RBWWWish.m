//
//  RBWWWish.m
//  Wishing Well
//
//  Created by Anatoly Ermolaev on 8/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//


#import "RBWWWish.h"
#import <Parse/PFObject+Subclass.h>

@implementation RBWWWish
+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"RBWWWish";
}

-(BOOL)validateForUpdate {
    if (!self.shortDescr) {
        return NO;
    }
    if (!self.priority) {
        return  NO;
    }
    if (!self.owner) {
        return NO;
    }
    return YES;
}

@dynamic shortDescr;
@dynamic priority;
@dynamic owner;

@end