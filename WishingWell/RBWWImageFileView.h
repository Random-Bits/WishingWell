//
//  RBWWImageFileView.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 9/03/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

IB_DESIGNABLE
@interface RBWWImageFileView : UIImageView


@property (nonatomic, strong) IBInspectable UIImage *placeholderImage;

- (void) setFile:(PFFile *)file;


@end
