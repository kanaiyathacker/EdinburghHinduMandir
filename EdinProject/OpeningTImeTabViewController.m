//
//  OpeningTImeTabViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 02/08/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "OpeningTImeTabViewController.h"
#import "CalendarData.h"
#import "MyCalendar.h"
#import "DateUtil.h"

@interface OpeningTImeTabViewController ()


@property (weak, nonatomic) IBOutlet UILabel *openingTimeSec;
@property (weak, nonatomic) IBOutlet UITextView *detailsSec;
@property (weak, nonatomic) IBOutlet UILabel *openingTimeThird;
@property (weak, nonatomic) IBOutlet UITextView *detailsThird;
@property (weak, nonatomic) IBOutlet UILabel *openingTimeFour;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UITextView *detailsFour;
@property (weak, nonatomic) IBOutlet UIButton *saveSecItem;
@property (weak, nonatomic) IBOutlet UIButton *saveThirdItem;
@property (weak, nonatomic) IBOutlet UIButton *saveFourItem;

@end

@implementation OpeningTImeTabViewController

- (IBAction)saveFirstItem:(id)sender {
            CalendarData *data = self.dataOfArray[0];
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data end]]
                 withTitle:data.summary inLocation:[data location]];
    
//    UIButton *button = sender;
//    button.enabled =  NO;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];

}

- (IBAction)saveSecItem:(id)sender {
    CalendarData *data = self.dataOfArray[1];
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data end]]
                 withTitle:data.summary inLocation:[data location]];
    
//    UIButton *button = sender;
//    button.enabled =  NO;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];
}
- (IBAction)saveThirdItem:(id)sender {
    CalendarData *data = self.dataOfArray[2];
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data end]]
                 withTitle:data.summary inLocation:[data location]];
    
 //   UIButton *button = sender;
//    button.enabled =  NO;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];
}
- (IBAction)saveFourItem:(id)sender {
    NSString *selIndex = [NSString stringWithFormat:@"%lu", (unsigned long)self.tabBarController.selectedIndex];
    CalendarData *data = self.dataOfArray[3];
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data end]]
                 withTitle:data.summary inLocation:[data location]];
    
 //   UIButton *button = sender;
//    button.enabled =  NO;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    
    CalendarData *data = self.dataOfArray[0];
//    self.openingTimeFirst.text = [self formatTimeWithStart:data.start andEnd:data.end];
//    self.detailsFirst.text = data.description;
    
    
    
}

-(void)disableSaveForExistingEvent
{
        NSString *selIndex = [NSString stringWithFormat:@"%lu", (unsigned long)self.tabBarController.selectedIndex];

    if(selIndex) {
        CalendarData *data = self.dataOfArray[[selIndex intValue]];
        BOOL val = [MyCalendar isEventStoredInCal:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:data.start]
                                              end:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:data.end]
                                            title:@"Mandir Opening Time"];
        if(val == YES) {
            [self.save setEnabled:NO];
    }

    }
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSString *selIndex = [NSString stringWithFormat:@"%lu", (unsigned long)tabBarController.selectedIndex];
    

    
    if([selIndex isEqualToString:@"0"] ) {
        CalendarData *data = self.dataOfArray[0];

        self.openingTimeFirst.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.detailsFirst.text = data.description;
    } else if([selIndex isEqualToString:@"1"] ) {
        CalendarData *data = self.dataOfArray[1];

        self.openingTimeSec.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.detailsSec.text = data.description;
    } else if([selIndex isEqualToString:@"2"] ) {
        CalendarData *data = self.dataOfArray[2];

        self.openingTimeThird.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.detailsThird.text = data.description;
    } else if([selIndex isEqualToString:@"3"] ) {
        CalendarData *data = self.dataOfArray[3];

        self.openingTimeFour.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.detailsFour.text = data.description;
    }
    
}

-(NSString *) formatDate:(NSString *)data
{
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ"
                       withStringDate:data];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    return [fmt stringFromDate:tmp];
}

/*
- (IBAction)createCalendarEvent:(id)sender {
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[self.data end]]
                 withTitle:@"Mandir Opening Time" inLocation:[self.data location]];
    
    [self.save setEnabled:NO];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];
    
}
*/

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
