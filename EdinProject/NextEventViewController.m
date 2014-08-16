//
//  NextEventViewController.m
//  EdinProject
//
//  Created by kanaiyathacker on 05/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "NextEventViewController.h"
#import "DateUtil.h"
#import "MyCalendar.h"

@interface NextEventViewController ()
@property (weak, nonatomic) IBOutlet UITextView *date;
@property (weak, nonatomic) IBOutlet UITextView *time;
@property (weak, nonatomic) IBOutlet UITextView *location;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *save;

@end

@implementation NextEventViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround.png"]];
    UIView *button = [self.view viewWithTag:200];
    
    CALayer *btnLayer = [button layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    [btnLayer setBorderWidth:1.0f];
    [btnLayer setBorderColor:[[UIColor whiteColor] CGColor]];

    
    [self loadData];
    [self disableSaveForExistingEvent];
    
        
    // Do any additional setup after loading the view.
}
- (IBAction)saveToCalendar:(id)sender {
    
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data end]]
                 withTitle:self.data.summary inLocation:[self.data location]];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];

    
}

-(void)disableSaveForExistingEvent
{
    BOOL val = [MyCalendar isEventStoredInCal:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:self.data.start]
                               end:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:self.data.end]
                             title:self.data.summary];
    if(val == YES) {
        [self.save setEnabled:NO];
    }
}
-(void)loadData
{
    self.date.text = [self formatDate:self.data.start];
    self.time.text = [self formatTimeWithStart:self.data.start andEnd:self.data.end];
    self.location.text = self.data.location;
    self.description.text = self.data.description;
    
    
 //   [self.description.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
  /*
    [self.description.layer setBorderColor: [[UIColor brownColor] CGColor]];
    [self.description.layer setBorderWidth: 1.0];
    [self.description.layer setCornerRadius:8.0f];
    [self.description.layer setMasksToBounds:YES];
    
    [self.date.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.date.layer setBorderWidth: 1.0];
    [self.date.layer setCornerRadius:8.0f];
    [self.date.layer setMasksToBounds:YES];
    
    [self.time.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.time.layer setBorderWidth: 1.0];
    [self.time.layer setCornerRadius:8.0f];
    [self.time.layer setMasksToBounds:YES];
    
    [self.location.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.location.layer setBorderWidth: 1.0];
    [self.location.layer setCornerRadius:8.0f];
    [self.location.layer setMasksToBounds:YES];
    */
    
    
}

-(NSString *) formatDate:(NSString *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                       withStringDate:data];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    return [fmt stringFromDate:tmp];
}

- (IBAction)createCalendarEvent:(id)sender {
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data end]]
                 withTitle:self.data.summary inLocation:[self.data location]];
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];
    
}

-(NSString *) formatTimeWithStart:(NSString *)start andEnd:(NSString *)end
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                       withStringDate:start];
    
    NSDate *tmp1 =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                        withStringDate:end];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm"];
    NSString *retVal = [NSString stringWithFormat:@"%@ - %@" , [fmt stringFromDate:tmp] ,[fmt stringFromDate:tmp1]];
    
    return retVal;
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
