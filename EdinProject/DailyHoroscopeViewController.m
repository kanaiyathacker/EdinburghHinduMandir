//
//  DailyHoroscopeViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 30/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "DailyHoroscopeViewController.h"
#import "AccessData.h"
#import "KGModal.h"



@interface DailyHoroscopeViewController ()
@property (nonatomic ,strong) AccessData *accessData;

@property (weak, nonatomic) IBOutlet UILabel *weeklyLableOne;
@property (weak, nonatomic) IBOutlet UILabel *weeklyLableTwo;
@property (weak, nonatomic) IBOutlet UILabel *monthlyLableOne;

@property (weak, nonatomic) IBOutlet UILabel *monthlyLableTwo;

@property (weak, nonatomic) IBOutlet UILabel *dailyLableOne;
@property (weak, nonatomic) IBOutlet UILabel *dailyLableTwo;

@property (weak, nonatomic) IBOutlet UILabel *yearlyLableOne;
@property (weak, nonatomic) IBOutlet UILabel *yearlyLableTwo;




@end

@implementation DailyHoroscopeViewController


-(void)popup
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"M/d/yyyy"];
    NSString *dateString = [df stringFromDate:[NSDate date]];
    
    NSDictionary *data = [self.accessData getBirthdayHoroscope:dateString withSign:self.horoscope];
    

//    NSString *title = [data allKeys][0];
//    NSUInteger location = [title rangeOfString:@"for"].location;
//    self.dailyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
//    self.dailyLableTwo.text = [title substringWithRange:NSMakeRange(location + 4 , [title length] - location - 4)];
//    
//    
//    ((UITextView*)[self.view viewWithTag:20]).text = [data valueForKey:[data allKeys][0]];
//    
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
}


-(NSString *) replaceString :(NSString *)str
{
    NSString *retVal = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return retVal;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor* color = [UIColor colorWithRed:(153/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    self.tabBarController.delegate = self;
    


    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : color }
                                             forState:UIControlStateReserved];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : color }
                                             forState:UIControlStateSelected];
    
    
    
    NSString *title = [[self.tabBarController.tabBar selectedItem] title];
    
    if([title isEqualToString:@"Daily"]) {
    
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"M/d/yyyy"];
        NSString *dateString = [df stringFromDate:[NSDate date]];
    
        UIColor  *uiColor = [UIColor colorWithRed:(171/255.0) green:(17/255.0) blue:(9/255.0) alpha:1];
    
        UIActivityIndicatorView *activityIndicator =
        [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(30, 0, 20, 20)];
        activityIndicator.color = uiColor;
        [self.tabBarController.tabBar addSubview:activityIndicator];
    
    
        [activityIndicator startAnimating];
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
        
        NSDictionary *data = [self.accessData getTodaysHoroscope:dateString withSign:self.horoscope];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(data && [[data allKeys] count] > 0){
                NSString *title = [data allKeys][0];
                NSUInteger location = [title rangeOfString:@"for"].location;
                self.dailyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
                self.dailyLableTwo.text = [title substringWithRange:NSMakeRange(location + 4 , [title length] -     location - 4)];
            
                ((UITextView*)[self.view viewWithTag:20]).text = [data valueForKey:[data allKeys][0]];
                [activityIndicator stopAnimating];

            }
        });
    });
    }

    // Do any additional setup after loading the view.
}

-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{    
    NSString *selIndex = [NSString stringWithFormat:@"%lu", (unsigned long)tabBarController.selectedIndex];
    UITabBarItem *item = [[tabBarController tabBar] items][0];

    if([selIndex isEqualToString:@"0"] ) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"M/d/yyyy"];
        NSString *dateString = [df stringFromDate:[NSDate date]];
        
        
      UIColor  *uiColor = [UIColor colorWithRed:(171/255.0) green:(17/255.0) blue:(9/255.0) alpha:1];
        
        UIActivityIndicatorView *activityIndicator =
        [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(30, 0, 20, 20)];
        activityIndicator.color = uiColor;
        [tabBarController.tabBar addSubview:activityIndicator];

        
        [activityIndicator startAnimating];

        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            
            NSDictionary *data = [self.accessData getTodaysHoroscope:dateString withSign:self.horoscope];
            dispatch_async(dispatch_get_main_queue(), ^{

                NSString *title = [self getTitle:data withKey:self.horoscope];
                NSUInteger location = [title rangeOfString:@"for"].location;
                if(location > 0 && location < [title length]) {
                    self.dailyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
                    self.dailyLableTwo.text = [title substringWithRange:NSMakeRange(location + 4 , [title length] - location - 4)];
                    ((UITextView*)[self.view viewWithTag:20]).text = [data valueForKey:[data allKeys][0]];
                }
                
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
                
            });
        });

              
    }else if([selIndex isEqualToString:@"1"] ) {

        UIColor  *uiColor = [UIColor colorWithRed:(171/255.0) green:(17/255.0) blue:(9/255.0) alpha:1];

        
        UIActivityIndicatorView *activityIndicator =
        [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110, 0, 20, 20)];
        activityIndicator.color =uiColor;
        [tabBarController.tabBar addSubview:activityIndicator];
        
        [activityIndicator startAnimating];
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            
            NSArray *data = [self.accessData getWeeklyHoroscope:self.horoscope];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ((UITextView*)[self.view viewWithTag:21]).text = [self getAppendedString:data];
                NSString *title = [self getTitleForArray:data withKey:self.horoscope];
                NSUInteger location = [title rangeOfString:@"from"].location;
                
                if(location > 0 && location < [title length]) {
                    self.weeklyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
                    self.weeklyLableTwo.text = [title substringWithRange:NSMakeRange(location + 5 , [title length] - location - 5)];
                }
                
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
            });
        });

        
        
     } else if([selIndex isEqualToString:@"2"] ) {
         UIColor  *uiColor = [UIColor colorWithRed:(171/255.0) green:(17/255.0) blue:(9/255.0) alpha:1];


         UIActivityIndicatorView *activityIndicator =
         [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(190, 0, 20, 20)];
         activityIndicator.color =uiColor;
         [tabBarController.tabBar addSubview:activityIndicator];
         [activityIndicator startAnimating];
         dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
         dispatch_async(myQueue, ^{
             
         NSArray *data = [self.accessData getMonthlysHoroscope:self.horoscope];
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 ((UITextView*)[self.view viewWithTag:22]).text = [self getAppendedString:data];
                 NSString *title = [self getTitleForArray:data withKey:self.horoscope];
                 NSUInteger location = [title rangeOfString:@"for"].location;
                 
                if(location > 0 && location < [title length]) {
                     self.monthlyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
                     self.monthlyLableTwo.text = [title substringWithRange:NSMakeRange(location + 4 , [title length] - location - 4)];
                 }
                 [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
             });
         });

         
         
         
         
     } else if([selIndex isEqualToString:@"3"] ) {

         UIColor  *uiColor = [UIColor colorWithRed:(171/255.0) green:(17/255.0) blue:(9/255.0) alpha:1];
         
         UIActivityIndicatorView *activityIndicator =
         [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(270, 0, 20, 20)];
         activityIndicator.color =uiColor;
         [tabBarController.tabBar addSubview:activityIndicator];
         [activityIndicator startAnimating];

         dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
         dispatch_async(myQueue, ^{
             
             NSArray *data = [self.accessData getYearlysHoroscope:self.horoscope];
             dispatch_async(dispatch_get_main_queue(), ^{
                 ((UITextView*)[self.view viewWithTag:24]).text = [self getAppendedString:data];
                 NSString *title = [self getTitleForArray:data withKey:self.horoscope];
                 NSUInteger location = [title rangeOfString:@"for"].location;
                 
                if(location > 0 && location < [title length]) {
                     self.yearlyLableOne.text = [title substringWithRange:NSMakeRange(0, location)];
                     self.yearlyLableTwo.text = [title substringWithRange:NSMakeRange(location + 4 , [title length] - location - 4)];
                 }
                 [activityIndicator stopAnimating];
                 [activityIndicator removeFromSuperview];
             });
         });

         
             }
}

-(NSString *)getTitle:(NSDictionary *)dic withKey:(NSString *)key
{
    NSArray *array = [dic allKeys];

    for(NSString *currVal in array) {
        if ([currVal rangeOfString:key].location != NSNotFound) {
            return currVal;
        }
    }
    return  @"";
}

-(NSString *)getTitleForArray:(NSArray *)array withKey:(NSString *)key
{

    for(NSString *currVal in array) {
        if ([currVal rangeOfString:key].location != NSNotFound) {
            return currVal;
        }
    }
    return  @"";
}

- (NSString*) getAppendedString:(NSArray*)array
{
    NSMutableString *str = [[NSMutableString alloc] init];
    int count =0;
    for(NSString *currVal in array) {
        if(count > 0)
            [str appendString:currVal];
        if([str isEqualToString:@"http://www.findyourfate.com/rss/news-rss.asp"]) {
            break;
        }
        count++;
    }
    return str;
}



@end
