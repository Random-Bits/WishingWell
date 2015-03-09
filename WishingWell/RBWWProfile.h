//
//  RBWWUserProfile.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 8/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import <Parse/Parse.h>

@interface RBWWProfile : PFObject <PFSubclassing>
@property (retain) NSString *firstName;
@property (retain) NSString *lastName;
@property (retain) NSDate *birthDate;
@property (retain) NSString *email;
@property (retain) PFFile *profilePhoto;
@property (retain) PFFile *thumbnail;
//@property (retain) PFRelation *users;

+ (NSString *)parseClassName;

+(void)requestProfileForUser:(PFUser *)user
                    withCompletionBlock:(void (^)(RBWWProfile *))completionBlock;

+(void)requestProfileForEmail:(NSString *)email
                    withCompletionBlock:(void (^)(RBWWProfile *))completionBlock;;

-(BOOL)isValidForUpdate;

-(void)setProfileImageWithData:(NSData *)imageData;

//-(void)saveProfile;

-(void)saveProfileWithBlock:(void(^)(BOOL saved, NSError *error))block;

@end
