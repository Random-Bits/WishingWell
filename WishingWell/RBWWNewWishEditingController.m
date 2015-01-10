//
//  RBWWNewWishEditingController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 26/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import "RBWWNewWishEditingController.h"
#import "RBWWWishDetailsTableViewController.h"

@interface RBWWNewWishEditingController ()

@end

@implementation RBWWNewWishEditingController

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
    [self.wishDetails saveWish];
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
