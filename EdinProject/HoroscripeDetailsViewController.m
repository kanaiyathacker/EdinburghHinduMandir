//
//  HoroscripeDetailsViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 30/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "HoroscripeDetailsViewController.h"
#import "DailyHoroscopeViewController.h"

@interface HoroscripeDetailsViewController () 

@end

@implementation HoroscripeDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
        self.tabBarController.delegate = self;
    
    
    NSArray *arr = self.viewControllers;
    DailyHoroscopeViewController *h = arr[0];
     h.horoscope=self.horoscope;
    h.uiNavigationItem = [self uiNavigationItem];
    
    DailyHoroscopeViewController *h1 = arr[1];
    h1.horoscope=self.horoscope;
    h1.uiNavigationItem = [self uiNavigationItem];
    
    DailyHoroscopeViewController *h2 = arr[2];
    h2.horoscope=self.horoscope;
    h2.uiNavigationItem = [self uiNavigationItem];
    
    DailyHoroscopeViewController *h3 = arr[3];
    h3.horoscope=self.horoscope;
    h3.uiNavigationItem = [self uiNavigationItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepageOpeningDetailsViewController:(HoroscripeDetailsViewController *)controller
                                forDetails:(NSString *)data
{

    controller.horoscope = data;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    

/*    if ([viewController isKindOfClass:[SecondViewController class]]){
        SecondViewController *svc = (SecondViewController *) viewController;
        svc.secondMutable = self.firstMutable;
    }
 */
    return TRUE;
}

@end
