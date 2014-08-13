//
//  YearlyTableViewController.m
//  EdinProject
//
//  Created by kanaiyathacker on 01/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "YearlyTableViewController.h"
#import "DateUtil.h"
#import "CalendarData.h"
#import "AccessData.h"
#import "EventDetialsViewController.h"

@interface YearlyTableViewController ()
@property (nonatomic , strong)NSArray *dataOfArray;
@property (nonatomic , strong)AccessData *accessData;
@end

@implementation YearlyTableViewController

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
}

-(void) loadData
{
    self.dataOfArray = [[self accessData] loadDataForYear];
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
    return [[self dataOfArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Yearly Event Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...

    
    cell.textLabel.font=[UIFont fontWithName:@"Times New Roman" size:15];
    cell.textLabel.text = [self formatDate:[self.dataOfArray objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [[self.dataOfArray objectAtIndex:indexPath.row] summary];
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
            if([segue.identifier isEqualToString:@"Event Details Seque"]) {
    
                if([segue.destinationViewController isKindOfClass:[EventDetialsViewController class]]) {
    
                    [self prepageOpeningDetailsViewController:segue.destinationViewController
                                                   forDetails:self.dataOfArray[indexPath.row]];
                }
            }
        }
    }
}

@end
