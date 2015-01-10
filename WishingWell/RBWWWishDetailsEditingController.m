//
//  RBWWWishDetailsEditingController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 26/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import "RBWWWishDetailsEditingController.h"
#import "RBWWWishDetailsTableViewController.h"

@interface RBWWWishDetailsEditingController ()<RBWWDetailsTableViewControllerDelegate>
@end

@implementation RBWWWishDetailsEditingController
@synthesize wishDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    if ([self class] == [RBWWWishDetailsEditingController class]) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    self.wishDetails.editing = editing;
    // Hide the back button when editing starts, and show it again when editing finishes.
    if ([self class] == [RBWWWishDetailsEditingController class]) {
        [self.navigationItem setHidesBackButton:editing animated:animated];
    };
    
    if (editing) {
        
    }
    else {
        // Save the changes.
        [self.wishDetails saveWish];
    }
}



#pragma mark - RBWWDetailsTableViewControllerDelegate

-(void)setRightBarButtonItemStateEnabled:(BOOL)enebled  {
    self.navigationItem.rightBarButtonItem.enabled = enebled;
}

-(void)dismissWishDetailsController:(RBWWWishDetailsTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toWishDetails"]) {
        
        self.wishDetails = (RBWWWishDetailsTableViewController *)[segue destinationViewController];
        self.wishDetails.delegate = self;
        self.wishDetails.wish = self.wishForEditing;
    }
    
}

@end
