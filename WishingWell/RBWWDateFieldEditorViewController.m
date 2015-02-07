//
//  RBWWDateFieldEditorViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 6/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWDateFieldEditorViewController.h"
#import <Parse/PFObject.h>

@interface RBWWDateFieldEditorViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dateEditor;

@end

@implementation RBWWDateFieldEditorViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.title = self.editedFieldName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        // Configure the user interface according to state.
    self.dateEditor.date = [self.editedObject valueForKey:self.editedFieldKey];
        //    [self.textField becomeFirstResponder];
}

#pragma mark - Save and cancel operations

- (IBAction)save:(id)sender
{
        // Pass current value to the edited object, then pop.
    [self.editedObject setValue:self.dateEditor.date forKey:self.editedFieldKey];
    [self.delegate editorDidChangedObject:self.editedObject];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cancel:(id)sender
{
        // Don't pass current value to the edited object, just pop.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
