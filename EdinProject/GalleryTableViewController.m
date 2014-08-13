//
//  GalleryTableViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 13/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "GalleryTableViewController.h"
#import "GalleryData.h"
#import "AccessData.h"
#import "GalleryPhotoViewController.h"


@interface GalleryTableViewController ()
@property (nonatomic, strong)NSArray *dataOfArray;
@property (nonatomic, strong)AccessData *accessData;

@end

@implementation GalleryTableViewController


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
    self.dataOfArray = [[self accessData] galleryList];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    int count = [self.dataOfArray count];
    if(count > 0) {
        int row = indexPath.row;
        cell.textLabel.text = [[self.dataOfArray objectAtIndex:indexPath.row ] title];
        NSString *ImageURL = [[self.dataOfArray objectAtIndex:indexPath.row ] imageUrl];
        

        NSURL *nsURl =[NSURL URLWithString:ImageURL];
        NSData *data = [[NSData alloc] initWithContentsOfURL:nsURl];
        UIImage *image = [UIImage imageWithData:data];
//        CGSize sacleSize = CGSizeMake(80, 60);
//        UIGraphicsBeginImageContextWithOptions(sacleSize, YES, 0.0);
//        [image drawInRect:CGRectMake(2, 2, sacleSize.width, sacleSize.height)];
//        UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        cell.imageView.image = image;
    
    }
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

-(void)prepageOpeningDetailsViewController:(GalleryPhotoViewController *)controller
                                forDetails:(GalleryData *)data
{


    controller.galleryData = [[self accessData] galleryListForSelectedAlbum:data.albumID];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath) {
            if([segue.identifier isEqualToString:@"GalleryImageCell"]) {
                if([segue.destinationViewController isKindOfClass:[GalleryPhotoViewController class]]) {
                    [self prepageOpeningDetailsViewController:segue.destinationViewController
                                                   forDetails:self.dataOfArray[indexPath.row]];
                }
            }
        }
    }
}


@end
