//
//  RBWWEventsTableViewController.m
//  WishingWell
//
//  Created by Anatoly Ermolaev on 27/01/2015.
//  Copyright (c) 2015 Random Bits. All rights reserved.
//

#import "RBWWEventsTableViewController.h"
#import "RBWWEvent.h"
#import <Parse/PFQuery.h>
#import "NSDate+NSDate_DateFormtting.h"
#import "RBWWNewEventEditingViewController.h"
#import "RBWWWishDetailsEditingController.h"

@interface RBWWEventsTableViewController ()

@end

@implementation RBWWEventsTableViewController

-(void)initView{
    self.parseClassName = @"RBWWEvent";
    self.title = @"My Events";
    self.pullToRefreshEnabled = YES;
    self.paginationEnabled = NO;
}

-(id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)viewDidLoad {
    if (self) {
        [self initView];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [query whereKey:@"ownersProfile" equalTo:self.profile];
    [query orderByDescending:@"eventDate"];
    
    return query;
}



    // Override to customize the look of a cell representing an object. The default is to display
    // a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"eventCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
        // Configure the cell
    cell.textLabel.text = ((RBWWEvent *)(object)).eventDescr;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Date: %@", [NSDate stringDateFromDate:((RBWWEvent *)(object)).eventDate]];
    
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
        //    [self performSegueWithIdentifier:@"toEventDetails" sender:self];
}



#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newEvent"]) {
        

        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        RBWWNewEventEditingViewController *newEventViewController = (RBWWNewEventEditingViewController *)[navController topViewController];
            //        newWishViewController.delegate = self;
        newEventViewController.eventForEditing = [RBWWEvent object];
        newEventViewController.eventForEditing.eventDescr = @"New Event";
        newEventViewController.eventForEditing.eventDate = [NSDate dateWithTimeIntervalSinceNow:0];
        [newEventViewController.eventForEditing setOwnersProfile:self.profile];
    }
    
    if ([[segue identifier] isEqualToString:@"toEventDetails"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
            // Pass the selected item to the new view controller.
        RBWWEventDetailsEditingViewController *detailsViewController = (RBWWEventDetailsEditingViewController *)[segue destinationViewController];
        detailsViewController.eventForEditing = (RBWWEvent *)[self objectAtIndexPath:indexPath];
            //        detailsViewController.delegate = self;
    }
    
}


@end
