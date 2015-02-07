//
//  RBWWEventDetailsEditingViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 6/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWEventDetailsEditingViewController.h"
#import "RBWWEventDetailsTableViewController.h"

@interface RBWWEventDetailsEditingViewController ()<RBWWEventDetailsTableViewControllerDelegate>
@end

@implementation RBWWEventDetailsEditingViewController
@synthesize eventDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do view setup here.
    if ([self class] == [RBWWEventDetailsEditingViewController class]) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    self.eventDetails.editing = editing;
        // Hide the back button when editing starts, and show it again when editing finishes.
    if ([self class] == [RBWWEventDetailsEditingViewController class]) {
        [self.navigationItem setHidesBackButton:editing animated:animated];
    };
    
    if (editing) {
        
    }
    else {
            // Save the changes.
        [self.eventDetails saveEvent];
    }
}



#pragma mark - RBWWDetailsTableViewControllerDelegate

-(void)setRightBarButtonItemStateEnabled:(BOOL)enebled  {
    self.navigationItem.rightBarButtonItem.enabled = enebled;
}

-(void)dismissEventDetailsController:(RBWWEventDetailsTableViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toEventDetails"]) {
        
        self.eventDetails = (RBWWEventDetailsTableViewController *)[segue destinationViewController];
        self.eventDetails.delegate = self;
        self.eventDetails.event = self.eventForEditing;
    }
    
}

@end
