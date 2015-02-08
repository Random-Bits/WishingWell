//
//  NSDate+NSDate_DateFormtting.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 27/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "NSDate+NSDate_DateFormtting.h"

@implementation NSDate (NSDate_DateFormtting)
+ (NSDateFormatter*)stringDateFormatter
{
    static NSDateFormatter* formatter = nil;
    if (formatter == nil)
        {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
        }
    return formatter;
}

+ (NSString*)stringDateFromDate:(NSDate*)date
{
    return [[self stringDateFormatter] stringFromDate:date];
}

@end
