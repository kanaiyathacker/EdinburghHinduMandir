//
//  HinduCalendarDetailViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 13/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "HinduCalendarDetailViewController.h"
#import "DateUtil.h"

@interface HinduCalendarDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *date;
@property (weak, nonatomic) IBOutlet UITextView *summary;
@property (weak, nonatomic) IBOutlet UITextView *description;

@end

@implementation HinduCalendarDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}


-(void)loadData
{
    

    self.date.text = [self formatDate:self.data.start];
    self.summary.text = self.data.summary;
    self.description.text = self.data.description;
    
    // [[self location] sizeToFit];
    
}

-(NSString *) formatDate:(NSString *)data
{
    
    NSDate *tmp =[DateUtil formatDate:@"YYYY-MM-dd"
                       withStringDate:data];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"dd-MM-yyyy"];
    
    return [fmt stringFromDate:tmp];
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
