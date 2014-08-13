//
//  EventsViewController.m
//  EdinProject
//
//  Created by kanaiyathacker on 29/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "EventsViewController.h"
#import "DateUtil.h"
#import "CalendarData.h"
#import "AccessData.h"
#import "EventDetialsViewController.h"

@interface EventsViewController ()
@property (nonatomic , strong)NSArray *dataOfArray;
@property (nonatomic , strong)AccessData *accessData;


@end

@implementation EventsViewController

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

   // [[self spinner] startAnimating];
    [self loadData];
   // [[self spinner] stopAnimating];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
        self.dataOfArray = [[self accessData] loadDataForYear];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [activityIndicator stopAnimating];
            
        });
    });
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
     if([self.dataOfArray count] == 0) {
         return 1;
     }
    return [[self dataOfArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Event Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //NSLog(@"%@" , [self formatDate:[self.timings objectAtIndex:indexPath.row]]);
    
    if([self.dataOfArray count] == 0) {
        cell.textLabel.text = @"Loading...";
        cell.detailTextLabel.text = @"";
    } else {
    
        cell.textLabel.text = [self formatDate:[self.dataOfArray objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = [[self.dataOfArray objectAtIndex:indexPath.row] summary];
    }
    return cell;
}

-(NSString *) formatDate:(CalendarData *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

-(void)prepageOpeningDetailsViewController:(EventDetialsViewController *)controller
                                forDetails:(CalendarData *)data
{

    controller.data = data;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath) {
            if([segue.identifier isEqualToString:@"Event Details"]) {
                if([segue.destinationViewController isKindOfClass:[EventDetialsViewController class]]) {
                    [self prepageOpeningDetailsViewController:segue.destinationViewController
                                                   forDetails:self.dataOfArray[indexPath.row]];
                }
            }
        }
    }
}

@end
