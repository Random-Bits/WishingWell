//
//  RBWWWishDetailsTableViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 13/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import "RBWWWishDetailsTableViewController.h"
#import "RBWWWish.h"
#import "RBWWFieldEditorViewController.h"
#import <Parse/PFUser.h>

@interface RBWWWishDetailsTableViewController () <RBWWFieldEditorDelegate>
//@property (nonatomic,weak) IBOutlet UILabel *wishDescription;
//@property (nonatomic,weak) IBOutlet UILabel *wishPriority;

- (void)updateInterface;
- (void)updateRightBarButtonItemState;
@end

@implementation RBWWWishDetailsTableViewController
@synthesize wish;

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
    [self.delegate setRightBarButtonItemStateEnabled:[self.wish validateForUpdate]];
    
}

-(void)saveWish {
    [self.wish saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
            NSLog(@"%@", self.wish);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:PAWPostCreatedNotification object:nil];
            [self.delegate dismissWishDetailsController:self]; // Dismiss the viewController upon success
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
        [self performSegueWithIdentifier:@"toSelectedFieldOfTheWish" sender:self];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier;
    switch (indexPath.row) {
        case 0: {
            CellIdentifier = @"descr";
        } break;
        case 1: {
            CellIdentifier = @"priority";
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
            cell.detailTextLabel.text = self.wish.shortDescr;
        } break;
        case 1: {
            cell.textLabel.text = @"Priority";
            cell.detailTextLabel.text = self.wish.priority;
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
    if ([[segue identifier] isEqualToString:@"toSelectedFieldOfTheWish"]) {
        
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        RBWWFieldEditorViewController *controller = (RBWWFieldEditorViewController *)[navController topViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        controller.editedObject = self.wish;
        controller.delegate = self;
        
        switch (indexPath.row) {
            case 0: {
                controller.editedFieldKey = @"shortDescr";
                controller.editedFieldName = NSLocalizedString(@"shortDescr", @"display name for Wish Description");
            } break;
            case 1: {
                controller.editedFieldKey = @"priority";
                controller.editedFieldName = NSLocalizedString(@"priority", @"display name for Wish Priority");
            } break;
        }
    }

}

#pragma mark - Field Editor delegate
-(void)editorDidChangedObject:(PFObject *)object {
    self.wish = (RBWWWish *)object;
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
