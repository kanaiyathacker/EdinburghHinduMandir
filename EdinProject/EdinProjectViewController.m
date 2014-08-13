//
//  EdinProjectViewController.m
//  EdinProject
//
//  Created by kanaiyathacker on 28/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "EdinProjectViewController.h"
#import "CalendarData.h"
#import "NextEventViewController.h"
#import "AccessData.h"
#import <EventKit/EventKit.h>
#import "MenuItemViewController.h"
#import "KGModal.h"



@interface EdinProjectViewController () <UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UILabel *openingTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (nonatomic , strong)AccessData *accessData;
@property (weak, nonatomic) IBOutlet UIButton *eventButton;
@property (nonatomic , strong)CalendarData *nextEventDetails;
@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic,weak) ADBannerView *adBanner;


@end
#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@implementation EdinProjectViewController

-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
}

-(CalendarData *)nextEventDetails
{
    if(!_nextEventDetails) _nextEventDetails = [[CalendarData alloc] init];
    return _nextEventDetails;
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

-(void)addBanner
{
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, 320, 50)];
    [self.view addSubview:_adBanner];	// Do any additional setup after loading the view, typically from a nib.
    _adBanner.delegate = self;

}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{

    
    if (!_bannerIsVisible)
    {
       
        // If banner isn't part of view hierarchy, add it
        if (_adBanner.superview == nil)
        {
            [self.view addSubview:_adBanner];
        }
        
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    
    
    if (_bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = NO;
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
        [self setOpeningTime];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"[UIDevice currentDevice] name] %@ - " , [[UIDevice currentDevice] name]);
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor blackColor];
    
    self.eventButton.hidden = YES;
    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index.png"]];
  //  bgImageView.frame = self.view.bounds;
  //  [self.view addSubview:bgImageView];
    //[self.view sendSubviewToBack:bgImageView];
    
//    [self.navigationController.navigationBar setBarTintColor :Rgb2UIColor(50, 177 , 223)];
    
  
  //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround.png"]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
   // UIImage *image = [UIImage imageNamed: @"AppIcon.png"];
    // UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    //imageView.frame = CGRectMake(15, -1, 50, 44);
    //[self.navigationController.navigationBar addSubview:imageView];
    
    NSMutableDictionary *textDic =[[NSMutableDictionary alloc] init];
    
    [textDic setValue:[UIFont fontWithName:@"Helvetica Neue Medium" size:14]
               forKey:NSFontAttributeName];
    
    [textDic setValue:[UIColor whiteColor]
               forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:textDic];
    
    
    [self.navigationController.navigationBar.topItem.leftBarButtonItem setTitleTextAttributes:textDic forState:UIControlStateNormal];
    
    [self.navigationController.navigationBar.topItem.rightBarButtonItem setTitleTextAttributes:textDic forState:UIControlStateNormal];

//    [self setEvents];
    
    if([[self accessData] connected] == YES) {
//    [self setOpeningTime];
       
//    [self addBanner];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"Cool-Red-Font.png"]
                                            forBarMetrics:UIBarMetricsDefault];
 
    
 //   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:
                                                                         //  green:
                                                                           // blue:];
    // Schedule the notification
   /* NSDate *dateTime = [NSDate date];

    NSTimeInterval secondsInEightHours = 8;
    NSDate *dateEightHoursAhead = [dateTime dateByAddingTimeInterval:secondsInEightHours];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = dateEightHoursAhead;
    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", dateTime];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.repeatInterval =0;
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    */
    
    } else {
        [self performSegueWithIdentifier: @"No Network" sender: self];
    }

    


    if ( [[(NSString*)[UIDevice currentDevice].model lowercaseString] hasPrefix:@"ipad"]){
        
        [[UIAlertView alloc] initWithTitle:nil
    message:@"Please access website or IPhone for better user experience" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil].show;
    }
        
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) animateTimingLabel
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    float Distance1 = 320.0f;
    float Distance2 = 320.0f;
    
    
    [animation setDuration:12];
    Distance1=320;
    Distance2=320;
    
    [animation setRepeatCount:100];
    [animation setAutoreverses:NO];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self.timeLable center].x - Distance1, [self.timeLable center].y)]];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self.timeLable center].x + Distance2, [self.timeLable center].y)]];
   // [[self.timeLable layer] addAnimation:animation forKey:@"position"];
  //  [NSTimer scheduledTimerWithTimeInterval:12 invocation:@selector("callMe") repeats:NO];
}


-(void)callMe
{
    
}
-(void)setEvents
{
    CalendarData *data = [[self accessData] getNextEvent];
    if(data) {
    self.nextEventDetails = data;
    [self.eventButton setTitle:[NSString stringWithFormat:@"%@ Read More...",[data summary]] forState:UIControlStateNormal];
    } else {
        [self.eventButton setHidden:YES];
    }
}
-(void)setOpeningTime
{
    
    NSLog(@"setOpeningTime");
    if([[self accessData] connected] == YES) {
    UIActivityIndicatorView *activityIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton =
    [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    
    [[self navigationItem] setRightBarButtonItem:barButton];
    
    [activityIndicator startAnimating];
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
            NSDictionary *data = [[self accessData] getMessageForOpeningTime];
            CalendarData *cData = [[self accessData] getNextEvent];
            dispatch_async(dispatch_get_main_queue(), ^{

            self.openingTimeLable.text = [data valueForKey:@"MSG"];
            self.timeLable.text = [data valueForKey:@"VAL"];
            [self animateTimingLabel];
                
                if(cData) {
                    [self.eventButton setHidden:NO];
                    self.nextEventDetails = cData;
                    [self.eventButton setTitle:[NSString stringWithFormat:@"%@",[cData summary]] forState:UIControlStateNormal];
                } else {
                    [self.eventButton setHidden:YES];
                }

                
            [activityIndicator stopAnimating];
   
        });
    });
    }
}

-(IBAction)btnStartClicked:(UIButton *)sender {
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                                        target:self
                                                      selector:@selector(calculateNextNumber)
                                                      userInfo:nil
                                                       repeats:YES];
    
    /*UIBackgroundTaskIdentifier backgroundTask= [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background handler called. Not running background tasks anymore.");
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
        self.backgroundTask = UIBackgroundTaskInvalid;
    }];
    */
}

-(void)calculateNextNumber{
    @autoreleasepool {
        // this will be executed no matter app is in foreground or background
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ie:(id)sender {
    NSString *stringURL = @"http://www.edinburghhindumandir.org.uk/";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)googlePlus:(id)sender {
    NSURL *facebookURL = [NSURL URLWithString:@"gplus://plus.google.com/+EdinburghhindumandirOrgUk"];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/+EdinburghhindumandirOrgUk"]];
    }
}

- (IBAction)twitter:(id)sender {
    NSURL *facebookURL = [NSURL URLWithString:@"twitter://user?screen_name=edinhindumandir"];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/edinhindumandir"]];
    }
}
- (IBAction)facebook:(id)sender {
    NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/212370715604446"];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/EdinburghHinduMandirCulturalCentre"]];
    }
}

-(void)prepageOpeningDetailsViewController:(NextEventViewController *)controller
                                forDetails:(CalendarData *)data
{

    controller.data = data;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([sender isKindOfClass:[UIButton class]]) {
       
        if([segue.identifier isEqualToString:@"Next Event"]) {
            if([segue.destinationViewController isKindOfClass:
                [NextEventViewController class]]) {
                    [self prepageOpeningDetailsViewController:segue.destinationViewController
                                                   forDetails:self.nextEventDetails];
            }
        } else if([segue.identifier isEqualToString:@"Menu"]) {
            if([segue.destinationViewController isKindOfClass:
                [MenuItemViewController class]]) {
              /*  UINavigationController *menu =segue.destinationViewController;
                menu.transitioningDelegate = self;
                menu.modalPresentationStyle = UIModalPresentationCustom;
                [self presentViewController:menu animated:YES completion:nil];
            
                
                CATransition *transition = [CATransition animation];
                transition.duration = 0.5;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionPush;
                transition.subtype = @"left";
                [self.view.layer addAnimation:transition forKey:kCATransition];
                
                MenuItemViewController *destViewController = segue.destinationViewController;
                UIView *destView = destViewController.view;
              //  destViewController.selectionName = @"alarms";
                
               // [sender setEnabled:NO];
                
                CGAffineTransform baseTransform = destView.transform; //1
                destView.transform = CGAffineTransformTranslate(baseTransform,0,destView.bounds.size.height); //2

                
                [UIView animateWithDuration: 0.5 animations:^{
                    destView.transform = baseTransform; //3
                }];
             */
               }
             
        }

    }
}


@end
