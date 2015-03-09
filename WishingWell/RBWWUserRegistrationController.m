//
//  RBWWUserRegistrationController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 2/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWUserRegistrationController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "RBWWUserDataTabBarController.h"
#import "RBWWLoginViewController.h"

@interface RBWWUserRegistrationController () <PFLogInViewControllerDelegate,
                                              PFSignUpViewControllerDelegate>
-(void)presentLoginViewController;
-(void)presentUserDataController;

@end

@implementation RBWWUserRegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"toPFLogin" sender:self];
        //[self presentLoginViewController];
    }
    else {
        [self performSegueWithIdentifier:@"toUserData" sender:self];
        //[self presentUserDataController];
    }

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"toPFLogin"]) {
        RBWWLoginViewController *login = (RBWWLoginViewController *)[segue destinationViewController];
        login.delegate = self;
    }
//    if ([[segue identifier] isEqualToString:@"toUserData"]) {
//        RBWWUserDataTabBarController  *userData = (RBWWUserDataTabBarController *)[segue destinationViewController];
//        userData.userDataDelegate = self;
//    }
}

#pragma mark UserDataController
-(void)presentUserDataController {
}

#pragma mark LoginViewController

- (void)presentLoginViewController {
    // Go to the welcome screen and have them log in or create an account.
    
    // Create the log in view controller
    RBWWLoginViewController *logInViewController = [[RBWWLoginViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    logInViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:logInViewController animated:YES completion:nil];
    //[self setViewControllers:@[ logInViewController ] animated:NO];
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

/*!
 @abstract Sent to the delegate when a <PFUser> is logged in.
 
 @param logInController The login view controller where login finished.
 @param user <PFUser> object that is a result of the login.
 */
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    __weak RBWWUserRegistrationController *weakSelf = self;
    [logInController dismissViewControllerAnimated:NO completion:^{
        [weakSelf performSegueWithIdentifier:@"toUserData" sender:weakSelf];
    }];
}

/*!
 @abstract Sent to the delegate when the log in attempt fails.
 
 @param logInController The login view controller where login failed.
 @param error `NSError` object representing the error that occured.
 */
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                message:@"Make sure you provide corrrect user name and password!"
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

/*!
 @abstract Sent to the delegate when the log in screen is cancelled.
 
 @param logInController The login view controller where login was cancelled.
 */
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    //[self.navigationController popViewControllerAnimated:YES];
}


//this one is called by unwind segue from RBWWUserDetailsTableViewController
-(IBAction)doLogout:(UIStoryboardSegue*)segue{
    [PFUser logOut];
}

@end
