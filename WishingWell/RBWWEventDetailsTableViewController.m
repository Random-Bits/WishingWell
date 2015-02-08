//
//  RBWWEventDetailsTableViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 5/02/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWEventDetailsTableViewController.h"

#import "RBWWEvent.h"
#import "RBWWFieldEditorViewController.h"
#import "RBWWDateFieldEditorViewController.h"
#import <Parse/PFUser.h>
#import "NSDate+NSDate_DateFormtting.h"

@interface RBWWEventDetailsTableViewController () <RBWWFieldEditorDelegate, RBWWDateFieldEditorDelegate>
- (void)updateInterface;
- (void)updateRightBarButtonItemState;
@end

@implementation RBWWEventDetailsTableViewController
@synthesize event;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateInterface];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
        // if the local changes behind our back, we need to be notified so we can update the date
        // format in the table view cells
        //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(localeChanged:)
                                                 name:NSCurrentLocaleDidChangeNotification
                                               object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSCurrentLocaleDidChangeNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
        // Redisplay the data.
    [self updateInterface];
    [self updateRightBarButtonItemState];
}




- (void)updateInterface {
    
        //    self.wishDescription.text = self.wish.shortDescr;
        //    self.wishPriority.text = self.wish.priority;
        //    [self.tableView setNeedsDisplay];
}

- (void)updateRightBarButtonItemState {
    
        // Conditionally enable the right bar button item -- it should only be enabled if the wish is in a valid state for saving.
    [self.delegate setRightBarButtonItemStateEnabled:[self.event isValidForUpdate]];
    
}

-(void)saveEvent {
    [self.event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Couldn't save!");
            NSLog(@"%@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            return;
        };
        if (succeeded) {
            NSLog(@"Successfully saved!");
            NSLog(@"%@", self.event);
                //            dispatch_async(dispatch_get_main_queue(), ^{
                //                [[NSNotificationCenter defaultCenter] postNotificationName:PAWPostCreatedNotification object:nil];
            [self.delegate dismissEventDetailsController:self]; // Dismiss the viewController upon success
        } else {
            NSLog(@"Failed to save.");
        }
    }];
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        // Only allow selection if editing.
    if (self.editing) {
        return indexPath;
    }
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

/*
 Manage row selection: If a row is selected, create a new editing view controller to edit the property associated with the selected row.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.editing) {
        NSString *identifier;
        switch (indexPath.row) {
            case 0:
                identifier = @"editEventName";
                break;
            case 1:
                identifier = @"editEventDate";
                break;
            default:
                identifier = @"editEventName";
                break;
        }
        [self performSegueWithIdentifier:identifier sender:self];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier;
    switch (indexPath.row) {
        case 0: {
            CellIdentifier = @"eventNameCell";
        } break;
        case 1: {
            CellIdentifier = @"eventDateCell";
        } break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    
        // Configure the cell
    switch (indexPath.row) {
        case 0: {
                cell.textLabel.text = @"Description";
            cell.detailTextLabel.text = self.event.eventDescr;
        } break;
        case 1: {
                cell.textLabel.text = @"Date";
            cell.detailTextLabel.text = [NSDate stringDateFromDate:self.event.eventDate];
        } break;
    }
    
    return cell;
}

#pragma mark - Table view data source


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
   
    if ([[segue identifier] isEqualToString:@"editEventName"]) {
        
        RBWWFieldEditorViewController *controller = (RBWWFieldEditorViewController *)[navController topViewController];

        
        controller.editedObject = self.event;
        controller.delegate = self;
        
        controller.editedFieldKey = @"eventDescr";
        controller.editedFieldName = NSLocalizedString(@"eventDescr", @"display name for Event Description");
    }
    if ([[segue identifier] isEqualToString:@"editEventDate"]) {
        

        RBWWFieldEditorViewController *controller = (RBWWFieldEditorViewController *)[navController topViewController];
        
        controller.editedObject = self.event;
        controller.delegate = self;
        
        controller.editedFieldKey = @"eventDate";
        controller.editedFieldName = NSLocalizedString(@"eventDate", @"display name for Event Date");
    }
    
}

#pragma mark - Field Editor delegate / Date Field Editor Delegate
-(void)editorDidChangedObject:(PFObject *)object {
    self.event = (RBWWEvent *)object;
    [self.tableView reloadData];
}

#pragma mark - Locale changes

- (void)localeChanged:(NSNotification *)notif
{
        // the user changed the locale (region format) in Settings, so we are notified here to
        // update the date format in the table view cells
        //
    [self updateInterface];
}
@end
