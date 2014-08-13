//
//  HoroscopeTableViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 30/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "HoroscopeTableViewController.h"
#import "HoroscripeDetailsViewController.h"
#import "KGModal.h"
#import "AccessData.h"

@interface HoroscopeTableViewController ()
@property (nonatomic , strong)NSArray *menuItem;
@property (nonatomic , strong)NSArray *imageItem;
@property (nonatomic ,strong) AccessData *accessData;

@end

@implementation HoroscopeTableViewController

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



-(void)popup
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M/d/yyyy"];
    NSString *dateString = [df stringFromDate:[NSDate date]];
    
    
    UIActivityIndicatorView *activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton =
    [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    [[self navigationItem] setRightBarButtonItem:barButton];
    
    [activityIndicator startAnimating];
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        NSDictionary *data = [self.accessData getBirthdayHoroscope:dateString withSign:@"Test"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)];
            
            CGRect welcomeLabelRect = contentView.bounds;
            welcomeLabelRect.origin.y = 20;
            welcomeLabelRect.size.height = 20;
            UIFont *welcomeLabelFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0];
            UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
            welcomeLabel.text = @"What's special today for you";
            welcomeLabel.font = welcomeLabelFont;
            welcomeLabel.textColor = [UIColor whiteColor];
            welcomeLabel.textAlignment = NSTextAlignmentCenter;
            welcomeLabel.backgroundColor = [UIColor clearColor];
            welcomeLabel.shadowColor = [UIColor blackColor];
            welcomeLabel.shadowOffset = CGSizeMake(0, 1);
            [contentView addSubview:welcomeLabel];
            
            CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
            infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
            infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 20;
            UITextView *infoLabel = [[UITextView alloc] initWithFrame:infoLabelRect];
            infoLabel.text = [self replaceString:[self replaceString:data[@"What's special today for you"]]];
            //    infoLabel.numberOfLines = 6;
            infoLabel.textColor = [UIColor whiteColor];
            infoLabel.textAlignment = NSTextAlignmentLeft;
            infoLabel.backgroundColor = [UIColor clearColor];
            infoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13.0];
            infoLabel.editable = NO;
            //  infoLabel.shadowColor = [UIColor blackColor];
            // infoLabel.shadowOffset = CGSizeMake(0, 1);
            [contentView addSubview:infoLabel];
            
            CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
            CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
            /*    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
             [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
             [contentView addSubview:btn];
             */
            //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
            [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];

            
            [activityIndicator stopAnimating];
            
        });
    });

    
    
   


    

    
    
    //    NSString *title = [data allKeys][0];
    //    NSUInteger location = [title rangeOfString:@"for"].location;
    //    self.dailyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
    //    self.dailyLableTwo.text = [title substringWithRange:NSMakeRange(location + 4 , [title length] - location - 4)];
    //
    //
    //    ((UITextView*)[self.view viewWithTag:20]).text = [data valueForKey:[data allKeys][0]];
    //
}


-(NSString *) replaceString :(NSString *)str
{
    NSString *retVal = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return retVal;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
         [self popup];
    _menuItem = @[@"Aries",@"Taurus",@"Gemini",@"Cancer",@"Leo",@"Virgo",@"Libra",@"Scorpio",@"Sagittarius",@"Capricorn",@"Aquarius",@"Pisces"];
    
    _imageItem = @[@"Aries.png",@"Taurus.png",@"Gemini.png",@"Cancer",@"Leo.png",@"Virgo.png",@"Libra.png",@"Scorpio.png",@"Sagittarius.png",@"Capricorn.png",@"Aquarius.png",@"Pisces.png"];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

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
        return [self.menuItem count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HoroscopeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.menuItem objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.imageItem objectAtIndex:indexPath.row]];
    
    
    return cell;

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

-(void)prepageOpeningDetailsViewController:(HoroscripeDetailsViewController *)controller
                                forDetails:(NSString *)data
{
    
    controller.horoscope = data;
    controller.uiNavigationItem = [self navigationItem];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath) {
            if([segue.identifier isEqualToString:@"HoroscopeDetails"]) {
                if([segue.destinationViewController isKindOfClass:[HoroscripeDetailsViewController class]]) {
                    
                    [self prepageOpeningDetailsViewController:segue.destinationViewController
                                                   forDetails: [self.menuItem objectAtIndex: indexPath.row]];
                }
            }
        }
    }
}



@end
