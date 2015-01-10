//
//  RBWWMyWishesTableViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 9/12/2014.
//  Copyright (c) 2014 Random Bits. All rights reserved.
//

#import "RBWWMyWishesTableViewController.h"
#import "RBWWWish.h"
#import <Parse/PFQuery.h>
#import "RBWWNewWishEditingController.h"
#import "RBWWWishDetailsEditingController.h"

@interface RBWWMyWishesTableViewController ()

@end

@implementation RBWWMyWishesTableViewController

-(void)initView {
    
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"RBWWWish";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"shortDescr";
        
        // The title for this table in the Navigation Controller.
        self.title = @"My Wishes";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        //self.objectsPerPage = 5;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    if (self) {
        [self initView];
    }
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query whereKey:@"owner" equalTo:[PFUser currentUser]];
    //[query orderByAscending:@"priority"];
    
    return query;
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = ((RBWWWish *)(object)).shortDescr;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@", ((RBWWWish *)(object)).priority];
    
    return cell;
}


/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - Table view data source


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }



 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
// else if (editingStyle == UITableViewCellEditingStyleInsert) {
// // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//     RBWWWish *newWish = [RBWWWish object];
//     newWish.shortDescr = @"New wish";
//     newWish.priority = @"High";
//     newWish.owner = [PFUser currentUser];
//     [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
// }
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toMyWishDetails" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newWish"]) {

        
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        RBWWNewWishEditingController *newWishViewController = (RBWWNewWishEditingController *)[navController topViewController];
//        newWishViewController.delegate = self;
        newWishViewController.wishForEditing = [RBWWWish object];
        newWishViewController.wishForEditing.priority = @"Low";
        [newWishViewController.wishForEditing setOwner:[PFUser currentUser]];
    }
    
    if ([[segue identifier] isEqualToString:@"toMyWishDetails"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Pass the selected item to the new view controller.
        RBWWWishDetailsEditingController *detailsViewController = (RBWWWishDetailsEditingController *)[segue destinationViewController];
        detailsViewController.wishForEditing = (RBWWWish *)[self objectAtIndexPath:indexPath];
//        detailsViewController.delegate = self;
    }

}

@end
