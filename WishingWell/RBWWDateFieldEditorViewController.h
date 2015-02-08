//
//  RBWWDateFieldEditorViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 6/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWFieldEditorViewController.h"
@class PFObject;

@protocol RBWWDateFieldEditorDelegate <NSObject>

-(void)editorDidChangedObject:(PFObject *)object;

@end

@interface RBWWDateFieldEditorViewController : UIViewController
@property (nonatomic, strong) PFObject *editedObject;
@property (nonatomic, strong) NSString *editedFieldKey;
@property (nonatomic, strong) NSString *editedFieldName;

@property (nonatomic,weak) id<RBWWDateFieldEditorDelegate> delegate;

@end

