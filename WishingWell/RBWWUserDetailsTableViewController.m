//
//  RBWWUserDetailsTabViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 22/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWUserDetailsTableViewController.h"
#import "RBWWProfile.h"
#import "RBWWUserProfileTableViewController.h"
#import "RBWWMyWishesTableViewController.h"
#import "RBWWEventsTableViewController.h"
#import "RBWWImageFileView.h"


@interface RBWWUserDetailsTableViewController () <RBWWUserProfileEditorDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *emailField;
@property (weak, nonatomic) IBOutlet UILabel *wishesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventsCountLabel;
@property (weak, nonatomic) IBOutlet RBWWImageFileView *profilePhoto;

@property (strong,nonatomic) RBWWProfile *profile;
@property (nonatomic,assign) BOOL isNew;
@property (nonatomic,assign) int numberOfWishes;
@property (nonatomic, assign) int numberOfEvents;

-(void)requestProfile;
-(void)updateUI;
@end

@implementation RBWWUserDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    if (!self.email) {
        self.email = [PFUser currentUser].email;
    }
    [self requestProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setProfile:(RBWWProfile *)profile
{
    _profile = profile;
    [self updateUI];
}

-(void)setNumberOfWishes:(int)numberOfWishes {
    _numberOfWishes = numberOfWishes;
    [self updateUI];
}

-(void)setNumberOfEvents:(int)numberOfEvents {
    _numberOfEvents = numberOfEvents;
    [self updateUI];
}
-(void)requestProfile
{
    if (self.refreshControl) {
        [self.refreshControl beginRefreshing];
    };
    [self refresh:self.refreshControl];

}

- (IBAction)refresh:(UIRefreshControl *)sender{
    __weak RBWWUserDetailsTableViewController *weakSelf = self;
    [RBWWProfile requestProfileForEmail:self.email
                               withCompletionBlock:^(RBWWProfile *requestedProfile){
                                   NSLog(@"Profile selected");
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       weakSelf.profile = requestedProfile;
                                       [weakSelf countWishesForProfile:requestedProfile];
                                       [sender endRefreshing];
                                   });
                                   [weakSelf countObjectsWithClassName:@"RBWWWish" forProfile:requestedProfile withBlock:^(int count, NSError *error) {
                                       if (!error) {
                                           weakSelf.numberOfWishes = count;
                                       }
                                   }];
                                   [weakSelf countObjectsWithClassName:@"RBWWEvent" forProfile:requestedProfile withBlock:^(int count, NSError *error) {
                                       if (!error) {
                                           weakSelf.numberOfEvents = count;
                                       }
                                   }];

                               }];

}

-(void)countObjectsWithClassName:(NSString *)className forProfile:(RBWWProfile *)profile withBlock:(void (^)(int count, NSError *error))countingBlock {
    PFQuery *countQuery = [PFQuery queryWithClassName:className];
    [countQuery whereKey:@"ownersProfile" equalTo:profile];
    [countQuery countObjectsInBackgroundWithBlock:^(int count, NSError *error){
        if (countingBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            countingBlock(count, error);
            
        });
        }
    }];

}

-(void)countWishesForProfile:(RBWWProfile *)profile {
    PFQuery *countQuery = [PFQuery queryWithClassName:@"RBWWWish"];
    [countQuery whereKey:@"ownersProfile" equalTo:profile];
    __weak RBWWUserDetailsTableViewController *weakSelf = self;
    [countQuery countObjectsInBackgroundWithBlock:^(int count, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.numberOfWishes = count;
        });
    }];
}

-(void)updateUI
{
    NSMutableString *nameString;
    if (self.profile.firstName) {
        nameString = [NSMutableString stringWithFormat:@"%@", self.profile.firstName];
    } else {
        nameString = [NSMutableString string];
    }
    if (self.profile.lastName) {
        [nameString appendString:[NSString stringWithFormat:@" %@", self.profile.lastName]];
    }
    if (!nameString) {
        nameString = [NSMutableString string];
    }
    self.nameField.text = nameString;
    self.emailField.text = self.profile.email;
    
    self.wishesCountLabel.text = (self.numberOfWishes == 0) ? @"Make a Wish!":[NSString stringWithFormat:@"%d Wish%@", self.numberOfWishes, self.numberOfWishes == 1 ? @"":@"es"];
    self.eventsCountLabel.text = (self.numberOfEvents == 0) ? @"Create Event!":[NSString stringWithFormat:@"%d Event%@", self.numberOfEvents, self.numberOfEvents == 1 ? @"":@"s"];
    [self.profilePhoto setFile:self.profile.profilePhoto];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Edit Profile"]) {
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        RBWWUserProfileTableViewController *upc = (RBWWUserProfileTableViewController *)nc.topViewController;
        upc.profile = self.profile;
        upc.delegate = self;
        upc.editing = YES;
    }
    if ([[segue identifier] isEqualToString:@"Show Wishes"]) {
        RBWWMyWishesTableViewController *wtvc = (RBWWMyWishesTableViewController *)((UINavigationController *)[segue destinationViewController]).topViewController;
        wtvc.profile = self.profile;
    }
    if ([[segue identifier] isEqualToString:@"Show Events"]) {
        RBWWEventsTableViewController  *etvc = (RBWWEventsTableViewController *)((UINavigationController *)[segue destinationViewController]).topViewController;
        etvc.profile = self.profile;
    }

}

#pragma mark - Unwind Handlers
-(IBAction)doCancelProfileEdit:(UIStoryboardSegue*)segue{
}

-(IBAction)doSaveProfileEdit:(UIStoryboardSegue*)segue{
    if ([[segue identifier] isEqualToString:@"Save Profile"]) {
        NSLog(@"Will request profile to be saved");
        [self.profile saveProfileWithBlock:^(BOOL saved, NSError *error) {
            if (error) {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            } else {
                NSLog(@"Profile saved!");
            }
            
        }];
    }
}

-(IBAction)backFromWishList:(UIStoryboardSegue *)segue {
    
}
-(IBAction)backFromEventsList:(UIStoryboardSegue *)segue {
    
}

#pragma mark - RBWWProfileEditorDelegate
-(void)profileEditor:(RBWWUserProfileTableViewController *)editor didSetPhoto:(UIImage *)newPhoto {
    self.profilePhoto.placeholderImage = newPhoto;
    [self.profilePhoto setFile:nil];
}

@end
