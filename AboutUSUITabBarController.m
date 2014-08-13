//
//  AboutUSUITabBarController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 04/08/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "AboutUSUITabBarController.h"

@interface AboutUSUITabBarController ()

@end

@implementation AboutUSUITabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor* color = [UIColor colorWithRed:(153/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : color }
                                             forState:UIControlStateReserved];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : color }
                                             forState:UIControlStateSelected];

    
}
@end
