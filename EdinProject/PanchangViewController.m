//
//  PanchangViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 01/08/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "PanchangViewController.h"
#import "AccessData.h"
@interface PanchangViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *sunRise;
@property (weak, nonatomic) IBOutlet UILabel *sunSet;
@property (strong, nonatomic)AccessData *accessData;
@end

@implementation PanchangViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView flashScrollIndicators];
    

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    
    self.scrollView.contentSize = CGSizeMake(20, 900);
    self.scrollView.frame = CGRectMake(5, 188, 310, 193);
    
    UIColor* labelColor = [UIColor colorWithRed:(80/255.0) green:(3/255.0) blue:(3/255.0) alpha:1];
    UIColor *textColor = self.sunRise.textColor;
    
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
        
    NSDictionary *dic =  [self.accessData getPanchang:dateString];
        dispatch_async(dispatch_get_main_queue(), ^{

            
            
            NSMutableString *textVal = [[NSMutableString alloc] init];
            NSString *description = [dic valueForKey:@"description"];
            NSArray *arr = [description componentsSeparatedByString:@"br/"];
            int paddFromTop=0;
            UIFont *fontRegular = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
            UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, paddFromTop, 200, 100)];
            label4.text = @"Location:";
            label4.font=[UIFont fontWithName:@"HelveticaNeue" size:14.0];
            label4.textColor = labelColor;
            [self.scrollView addSubview:label4];
            
            UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(110, paddFromTop, 200, 100)];
            label5.text = @"Edinburgh";
            label5.font=font;
            label5.textColor = textColor;
            [self.scrollView addSubview:label5];
            paddFromTop=paddFromTop +35;
            
            UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, paddFromTop, 200, 100)];
            label6.text = @"Date:";
            label6.font=fontRegular;
            label6.textColor = labelColor;
            [self.scrollView addSubview:label6];
            
            
            UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(110, paddFromTop, 200, 100)];
            label7.text = dateString;
            label7.font=font;
            [self.scrollView addSubview:label7];
            label7.textColor = textColor;
            paddFromTop=paddFromTop +35;
            
            for(NSString *curr in arr) {
                NSArray *splitVal = [curr componentsSeparatedByString:@"/b"];
                if([splitVal count] > 1) {
                    if ([splitVal[0] rangeOfString:@"Sunrise/Set"].location != NSNotFound) {
                        NSArray *split = [splitVal[1] componentsSeparatedByString:@"/"];
                        self.sunRise.text = split[0];
                        self.sunSet.text = split[1];
                    } else if ([splitVal[0] rangeOfString:@"Shravana"].location == NSNotFound) {
                        CGRect imageRect = CGRectMake(0.0, paddFromTop, 200, 100);
                        UILabel *label = [[UILabel alloc] initWithFrame:imageRect];
                        label.text = splitVal[0];
                        label.font=fontRegular;
                        label.textColor = labelColor;
                        [self.scrollView addSubview:label];
                        
                        CGRect imageRect1 = CGRectMake(105, paddFromTop, 200, 100);
                        UILabel *label1 = [[UILabel alloc] initWithFrame:imageRect1];
                        label1.text = splitVal[1];
                        label1.font=font;
                        label1.textColor = textColor;
                        [self.scrollView addSubview:label1];
                        paddFromTop=paddFromTop +35;
                    }
                }
            }
            self.textView.text = textVal;
            
            [activityIndicator stopAnimating];
            
        });
    });


    
    // Do any additional setup after loading the view.
}

-(NSString *)trim:(NSString *)field
{
    return [field stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


-(NSString *)padding:(NSString *)field
{
    NSMutableString *str = [[NSMutableString alloc] init];
    int padding = 20- [field length];
    while(padding > 0 ) {
        [str appendString:@" "];
        padding--;
    }

    return str;
}

-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
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
