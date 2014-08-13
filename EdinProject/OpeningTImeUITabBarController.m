//
//  OpeningTImeUITabBarController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 02/08/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "OpeningTImeUITabBarController.h"
#import "OpeningTImeTabViewController.h"
#import "AccessData.h"
#import "DateUtil.h"

@interface OpeningTImeUITabBarController ()
@property (nonatomic , strong)NSArray *dataOfArray;
@property (nonatomic , strong)AccessData *accessData;

@end

@implementation OpeningTImeUITabBarController


-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
}

-(void)selectorToDownloadImage:(NSObject *)obj
{
    [self loadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadData];
    
    
    
    UIColor* color = [UIColor colorWithRed:(153/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : color}
                                             forState:UIControlStateSelected];

  
    
}


-(NSString *) formatDate:(CalendarData *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                       withStringDate:data.start];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    return [fmt stringFromDate:tmp];
}

-(NSString *) formatTime:(CalendarData *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                       withStringDate:data.start];
    
    NSDate *tmp1 =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                        withStringDate:data.end];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm"];
    NSString *retVal = [NSString stringWithFormat:@"%@ - %@" , [fmt stringFromDate:tmp] ,[fmt stringFromDate:tmp1]];
    
    return retVal;
}

-(void) loadData
{
    UIActivityIndicatorView *activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton =
    [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    // Set to Left or Right
    [[self navigationItem] setRightBarButtonItem:barButton];
    
    [activityIndicator startAnimating];
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{

            self.dataOfArray = [[self accessData] loadDataForMonth];
        dispatch_async(dispatch_get_main_queue(), ^{
            

            
            NSArray *arr = self.viewControllers;
            OpeningTImeTabViewController *h = arr[0];
            h.dataOfArray=self.dataOfArray;
            [h setTitle:[self formatDate:[self.dataOfArray objectAtIndex:0]]];
            
            
            OpeningTImeTabViewController *h1 = arr[1];
            h1.dataOfArray=self.dataOfArray;
            [h1 setTitle:[self formatDate:[self.dataOfArray objectAtIndex:1]]];
            
            OpeningTImeTabViewController *h2 = arr[2];
            h2.dataOfArray=self.dataOfArray;
            [h2 setTitle:[self formatDate:[self.dataOfArray objectAtIndex:2]]];
            
            OpeningTImeTabViewController *h3 = arr[3];
            h3.dataOfArray=self.dataOfArray;
            [h3 setTitle:[self formatDate:[self.dataOfArray objectAtIndex:3]]];

            CalendarData *data = self.dataOfArray[0];
            h.openingTimeFirst.text = [h formatTimeWithStart:data.start andEnd:data.end];
            h.detailsFirst.text = data.description;
            
            [activityIndicator stopAnimating];
            
        });
    });
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
