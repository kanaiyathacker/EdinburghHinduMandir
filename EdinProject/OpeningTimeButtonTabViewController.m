//
//  OpeningTimeButtonTabViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 15/08/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "OpeningTimeButtonTabViewController.h"
#import "RecipeSegmentControl.h"
#import "AccessData.h"
#import "DateUtil.h"
#import "MyCalendar.h"



@interface OpeningTimeButtonTabViewController ()
@property (nonatomic , strong)NSArray *dataOfArray;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *openingTIme;
@property int selectdIndex;
@property (nonatomic , strong)AccessData *accessData;
@end

@implementation OpeningTimeButtonTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *button = [self.view viewWithTag:200];
    
    CALayer *btnLayer = [button layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    [btnLayer setBorderWidth:1.0f];
    [btnLayer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self loadData];
}

-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
}

- (IBAction)saveToCalendar:(id)sender {
    
    if(self.dataOfArray) {
    
    CalendarData *data = self.dataOfArray[self.selectdIndex];
    [MyCalendar addEventAt:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data start]]
               withEndDate:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data end]]
                 withTitle:data.summary inLocation:[data location]];
    
    NSString *eventID = [MyCalendar getEventID :[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data start]]
                                            end:[DateUtil formatDate:@"YYYY-MM-dd'T'HH:mm:ssZ" withStringDate:[data end]]
                                          title:data.summary
                         ];
    
    NSString *eventLink =  [NSString stringWithFormat:@"calshow://?eventid=%@" , eventID];
    NSLog(@"url %@ " , eventLink);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:eventLink]];
    }
    
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
            RecipeSegmentControl *control = [[RecipeSegmentControl alloc] init];
            control.dataOfArray = self.dataOfArray;
            control.openingTimeButtonTabViewController = self;
            NSString *title =  [self formatDate:[self.dataOfArray objectAtIndex:0]];
            NSString *title1 =  [self formatDate:[self.dataOfArray objectAtIndex:1]];
            NSString *title2 =  [self formatDate:[self.dataOfArray objectAtIndex:2]];
            NSString *title3 =  [self formatDate:[self.dataOfArray objectAtIndex:3]];
            NSArray *array = @[title , title1 , title2 , title3];

            [control initial:array];
            [self.view addSubview:control];
            [self.view sendSubviewToBack:control];
            [self selectedIndex:100];
            [activityIndicator stopAnimating];
            
        });
    });
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

-(void)selectedIndex:(int)index
{

    
    self.selectdIndex = index -100;
    if(index == 100) {
        CalendarData *data = self.dataOfArray[0];

        self.openingTIme.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.textView.text = data.description;
    } else if(index == 101) {
        CalendarData *data = self.dataOfArray[1];
        
        self.openingTIme.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.textView.text = data.description;
    } else if(index == 102) {
        CalendarData *data = self.dataOfArray[2];
        
        self.openingTIme.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.textView.text = data.description;
    } else if(index == 103) {
        CalendarData *data = self.dataOfArray[3];
        
        self.openingTIme.text = [self formatTimeWithStart:data.start andEnd:data.end];
        self.textView.text = data.description;
    }
    
}

@end
