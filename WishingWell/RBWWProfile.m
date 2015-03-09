//
//  RBWWUserProfile.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 8/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWProfile.h"
#import "UIImage+ResizeAdditions.h"

@interface RBWWProfile()
@property (nonatomic, assign, getter=isNew) BOOL newlyCreated;
@property (nonatomic, strong) NSData *profileImage;
@property (nonatomic,assign,getter=isImageChanged) BOOL imageChanged;
@end

@implementation RBWWProfile

@synthesize profileImage;
@synthesize imageChanged;
@synthesize newlyCreated;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"RBWWProfile";
}

+(void)requestProfileForEmail:(NSString *)email
          withCompletionBlock:(void (^)(RBWWProfile *))completionBlock
{
    PFQuery *profilesForEmail = [PFQuery queryWithClassName:[self parseClassName]];
    [profilesForEmail whereKey:@"email" containsString:email];
    [profilesForEmail getFirstObjectInBackgroundWithBlock:^(PFObject* object, NSError* error){
        
        if (error || !object){
            NSLog(@"The getFirstObject request failed.");
            RBWWProfile *profile = [RBWWProfile object];
            profile.imageChanged = NO;
            profile.newlyCreated = YES;
            profile.email = email;
            profile.firstName = @"";
            profile.lastName = @"";
            profile.birthDate = [NSDate date];
            NSLog(@"New profile object created.");
            if (completionBlock) {
                completionBlock(profile);
            }
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            if (completionBlock) {
                RBWWProfile *profile = (RBWWProfile *)object;
                profile.newlyCreated = NO;
                if (completionBlock) {
                    completionBlock(profile);
                }
            }
        }
    }];
}

+(void)requestProfileForUser:(PFUser *)user
         withCompletionBlock:(void (^)(RBWWProfile *))completionBlock
{
    [RBWWProfile requestProfileForEmail:user.email withCompletionBlock:completionBlock];
}


-(BOOL)isValidForUpdate {
    if (!self.firstName) {
        return NO;
    }
    if (!self.email) {
        return  NO;
    }
    return YES;
}

-(void)saveAndAssignToUser:(PFUser *)user
                 withBlock:(void(^)(BOOL assigned, NSError *error))completionBlock
{
    __weak RBWWProfile *weakSelf = self;
    __weak PFUser *weakUser = user;
    
    [self saveProfileWithBlock:^(BOOL saved, NSError *error){
        if (error) {
            completionBlock(NO,error);
        } else {
            PFRelation* userProfile = [weakUser relationForKey:@"profiles"];
            [userProfile addObject:weakSelf];
            [weakUser saveInBackgroundWithBlock:^(BOOL secceeded, NSError* error){
                if (!error) {
                    NSLog(@"PFUser object updated with relationship.");
                    PFRelation* users = [weakSelf relationForKey:@"users"];
                    [users addObject:weakUser];
                    [weakSelf saveInBackgroundWithBlock:^(BOOL secceeded, NSError* error){
                        if (!error) {
                            NSLog(@"New profile object updated with relationship to the user.");
                            completionBlock(YES, nil);
                        } else{
                            completionBlock(NO, error);
                        }
                    }];
                } else {
                    completionBlock(NO, error);
                }
            }];
        };
    }];
}

-(void)savePhotoWithBlock:(void (^)(BOOL, NSError *))completionBlock {
    if ([self isImageChanged]) {
        __weak RBWWProfile *weakSelf = self;
        if (self.profileImage.length > 0) {
            NSLog(@"Start saving main photo");
            PFFile *largePhoto = [PFFile fileWithData:UIImageJPEGRepresentation([[UIImage imageWithData:self.profileImage] thumbnailImage:130
                                                                                                                           transparentBorder:0
                                                                                                                                cornerRadius:0
                                                                                                                        interpolationQuality:kCGInterpolationHigh], 0.5)];
            [largePhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Main photo saved");
                    weakSelf.profilePhoto = largePhoto;
                    
                    NSLog(@"Start saving thumbnail");
                    PFFile *thumbnail = [PFFile fileWithData:UIImagePNGRepresentation([[UIImage imageWithData:weakSelf.profileImage] thumbnailImage:64
                                                                                                                                  transparentBorder:0
                                                                                                                                       cornerRadius:0
                                                                                                                               interpolationQuality:kCGInterpolationLow])];
                    [thumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"Thumbnail saved");
                            weakSelf.thumbnail = thumbnail;
                            completionBlock(YES,nil);
                        } else {
                            NSLog(@"Error on thumbnail: %@ %@", error, [error userInfo]);
                            completionBlock(NO,error);
                        }
                    }];
                } else {
                    NSLog(@"Error on large photo: %@ %@", error, [error userInfo]);
                    completionBlock(NO, error);
                }
            }];
        }
    } else {
        //no updates to photo required, no error
        if (completionBlock) {
            NSLog(@"No update to photo is required");
            completionBlock(NO,nil);
        }
    }
}

-(void)setProfileImageWithData:(NSData *)imageData {
    self.profileImage = imageData;
    self.imageChanged = YES;
}


-(void)saveProfileWithBlock:(void(^)(BOOL saved, NSError *error))block
{
    __weak RBWWProfile *weakSelf = self;
    [self savePhotoWithBlock:^(BOOL saved, NSError *error) {
        if (saved == NO && error) {
            NSLog(@"Failed to save new profile photo!!!");
        } else if (!error) {
            weakSelf.profileImage = nil;
            weakSelf.imageChanged = NO;
            if ([self isNew]) {
                [self saveAndAssignToUser:[PFUser currentUser] withBlock:^(BOOL assigned, NSError *error) {
                    NSLog(@"Finish creating new profile");
                    if (block) {
                        block(assigned, error);
                    }
                }];
            } else {
                [self saveInBackgroundWithBlock:^(BOOL secceeded, NSError* error){
                    if (block) {
                        block(secceeded, error);
                    }
                }];
            }
        }
    }];
}

@dynamic firstName;
@dynamic lastName;
@dynamic birthDate;
@dynamic email;
@dynamic profilePhoto;
@dynamic thumbnail;
@end
