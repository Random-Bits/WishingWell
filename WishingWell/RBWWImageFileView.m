//
//  RBWWImageFileView.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 9/03/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWImageFileView.h"
@interface RBWWImageFileView ()

@property (nonatomic, strong) NSString *url;

@end

@implementation RBWWImageFileView

@synthesize url;
@synthesize placeholderImage;

#pragma mark - PAPImageView

- (void) setFile:(PFFile *)file {
    
    if (file == nil) {
        [self setUrl:nil];
        [self setImage:self.placeholderImage];
        [self setNeedsDisplay];
    } else {
        
        NSString *requestURL = file.url; // Save copy of url locally (will not change in block)
        [self setUrl:file.url]; // Save copy of url on the instance
        
        if ([file isDataAvailable]) {
            NSLog(@"Photo in memory");
        } else {
            NSLog(@"Photo not in memory");
        }
        RBWWImageFileView *weakSelf = self;
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                if ([requestURL isEqualToString:weakSelf.url]) {
                    [weakSelf setImage:image];
                    [weakSelf setNeedsDisplay];
                }
            } else {
                NSLog(@"Error on fetching file");
            }
        }];
    }
}
@end
