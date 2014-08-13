//
//  HinduCalendarTableViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 13/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "HinduCalendarTableViewController.h"
#import "AccessData.h"
#import "DateUtil.h"
#import "HinduCalendarDetailViewController.h"


@interface HinduCalendarTableViewController () <UISearchDisplayDelegate>
@property (nonatomic , strong)NSArray *dataOfArray;
@property (nonatomic , strong)AccessData *accessData;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIColor *textCol;
@property (nonatomic, strong) UIColor *descTextCol;
@property (nonatomic, strong) UIColor *tableBackground;
@end

@implementation HinduCalendarTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
    // [[self spinner] stopAnimating];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{

    
    [self.searchResults removeAllObjects];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.summary contains[cd] %@",
                                    searchText];
    

    self.searchResults = [NSMutableArray arrayWithArray:[self.dataOfArray filteredArrayUsingPredicate:resultPredicate]];
    //[self.tableData filteredArrayUsingPredicate:resultPredicate];

    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    

    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];

    
    return YES;
}

-(void) loadData
{

    UIActivityIndicatorView *activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton =
    [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    [[self navigationItem] setRightBarButtonItem:barButton];
    
    [activityIndicator startAnimating];
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        self.dataOfArray = [[self accessData] loadDataForHinduCalendar];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                self.searchResults = [NSMutableArray arrayWithCapacity:[self.dataOfArray count]];
            [self.tableView reloadData];
            
            [activityIndicator stopAnimating];
            
        });
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
//    return [[self dataOfArray] count];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    } else {
        if([self.dataOfArray count] == 0) {
            return 1;
        } else {
            return [self.dataOfArray count];
        }
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    
    if([self.dataOfArray count] == 0) {
        cell.textLabel.text = @"Loading...";
        cell.detailTextLabel.text = @"";
        self.textCol = cell.textLabel.textColor;
        self.descTextCol = cell.detailTextLabel.textColor;
        self.tableBackground = tableView.backgroundColor;

    } else if (tableView == self.searchDisplayController.searchResultsTableView) {

        cell.textLabel.text = [self formatDate:[self.searchResults objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [[self.searchResults objectAtIndex:indexPath.row] summary];
        cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        cell.detailTextLabel.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
        cell.textLabel.textColor = self.textCol;
        cell.detailTextLabel.textColor = self.descTextCol;
        tableView.backgroundColor = self.tableBackground;
        cell.backgroundColor = self.tableBackground;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
        tableView.separatorColor = [UIColor blackColor];
    } else {
        cell.textLabel.text = [self formatDate:[self.dataOfArray objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [[self.dataOfArray objectAtIndex:indexPath.row] summary];
        self.textCol = cell.textLabel.textColor;
        self.descTextCol = cell.detailTextLabel.textColor;
        self.tableBackground = tableView.backgroundColor;
    }

    
    
  /*  if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [self formatDate:[self.searchResult objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [[self.searchResult objectAtIndex:indexPath.row] summary];    }
    else
    {
        cell.textLabel.text = [self formatDate:[self.dataOfArray objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [[self.dataOfArray objectAtIndex:indexPath.row] summary];    }
   */
    return cell;
}

-(NSString *) formatDate:(CalendarData *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd"
                       withStringDate:data.start];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    return [fmt stringFromDate:tmp];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

-(void)prepageOpeningDetailsViewController:(HinduCalendarDetailViewController *)controller
                                forDetails:(int)data flag:(BOOL)flag
{
    if(flag) {
       controller.data = self.searchResults[data];
    } else {
        controller.data = self.dataOfArray[data];
    }
//    controller.data = data;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
    BOOL flag = NO;
    if([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(!indexPath){
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            flag = YES;
        }
        if(indexPath) {
            if([segue.identifier isEqualToString:@"Hindu Calendar Event Details1"]) {


                if([segue.destinationViewController isKindOfClass:[HinduCalendarDetailViewController class]]) {
                    
                    [self prepageOpeningDetailsViewController:segue.destinationViewController
                                                   forDetails:indexPath.row
                     flag:flag];
                }
            }
        }
    }
}


@end
