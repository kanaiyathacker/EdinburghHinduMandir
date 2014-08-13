//
//  EdinProjectViewController.h
//  EdinProject
//
//  Created by kanaiyathacker on 28/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAD.h>

@interface EdinProjectViewController : UIViewController <ADBannerViewDelegate>
@property (nonatomic ,weak) NSArray *colorToAnimate;
-(void)setOpeningTime;
@end
