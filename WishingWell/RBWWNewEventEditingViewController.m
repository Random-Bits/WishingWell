//
//  RBWWNewEventDatailsEditingViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 6/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWNewEventEditingViewController.h"
#import "RBWWEventDetailsTableViewController.h"

@implementation RBWWNewEventEditingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.editing = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
- (IBAction)actionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionSave:(id)sender {
    [self.eventDetails saveEvent];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
