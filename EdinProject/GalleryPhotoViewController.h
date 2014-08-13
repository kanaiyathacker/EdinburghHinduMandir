//
//  GalleryPhotoViewController.h
//  Hindu Mandir
//
//  Created by kanaiyathacker on 15/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideImageView.h"
#import "GalleryData.h"

@interface GalleryPhotoViewController : UIViewController  <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@property(nonatomic ,strong)UILabel *indexLabel;
@property(nonatomic ,strong)UILabel *clickLabel;
@property(nonatomic ,strong)NSArray *galleryData;
-(void)startSpinner;
@end
