//
//  RBWWFieldEditorViewController.h
//  WishingWell
//
//  Created by Anatoly Ermolaev on 28/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PFObject;

@protocol RBWWFieldEditorDelegate <NSObject>

-(void)editorDidChangedObject:(PFObject *)object;

@end

@interface RBWWFieldEditorViewController : UIViewController
@property (nonatomic, strong) PFObject *editedObject;
@property (nonatomic, strong) NSString *editedFieldKey;
@property (nonatomic, strong) NSString *editedFieldName;

@property (nonatomic,weak) id<RBWWFieldEditorDelegate> delegate;

@end
