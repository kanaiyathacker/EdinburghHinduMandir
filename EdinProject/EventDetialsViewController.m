//
//  EventDetialsViewController.m
//  EdinProject
//
//  Created by kanaiyathacker on 29/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "EventDetialsViewController.h"
#import "DateUtil.h"
#import "MyCalendar.h"

@interface EventDetialsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *date;
@property (weak, nonatomic) IBOutlet UITextView *time;
@property (weak, nonatomic) IBOutlet UITextView *location;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *save;

@end

@implementation EventDetialsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
	[self disableSaveForExistingEvent];
    
    // Do any additional setup after loading the view.
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
    
    // [[self location] sizeToFit];
    
}

-(NSString *) formatDate:(NSString *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                       withStringDate:data];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    return [fmt stringFromDate:tmp];
}
- (IBAction)saveToCalendar:(id)sender {
    
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data start]]
withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data end]]
withTitle:self.data.summary inLocation:[self.data location]];
    
    [self.save setEnabled:NO];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];
}

- (IBAction)createCalendarEvent:(id)sender {
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data end]]
                 withTitle:self.data.summary inLocation:[self.data location]];
    
    [self.save setEnabled:NO];
    
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
@end
