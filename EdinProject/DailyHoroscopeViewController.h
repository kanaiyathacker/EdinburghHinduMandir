//
//  DailyHoroscopeViewController.h
//  Hindu Mandir
//
//  Created by kanaiyathacker on 30/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyHoroscopeViewController : UIViewController <UITabBarControllerDelegate>
@property (nonatomic, strong) NSString *horoscope;
@property (nonatomic, strong) UINavigationItem *uiNavigationItem;

@end
