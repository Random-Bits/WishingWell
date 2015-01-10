//
//  RBWWUserDataTabBarController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 2/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWUserDataTabBarController.h"
#import "RBWWUserProfileController.h"

@interface RBWWUserDataTabBarController () <RBWWUserProfileControllerDelegate>

@end

@implementation RBWWUserDataTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *vcList = self.viewControllers;
    for (UIViewController *vc in vcList) {
        if ([vc isMemberOfClass:[RBWWUserProfileController class]]) {
            ((RBWWUserProfileController *)vc).delegate = self;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - RBWWUserProfileControllerDelegate

-(void)performLogoutWithUserProfileController:(RBWWUserProfileController *)profileController {
    [self.userDataDelegate performUserLogoutWithController:self];
}

@end
