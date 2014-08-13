//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController () <UIScrollViewDelegate>
@property (nonatomic ,strong) UIImage *image;
@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation PageContentViewController

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
   // self.scrollView.contentSize = self.image ? self.image.size :CGSizeZero;
    
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
-(UIImageView *)imageView
{
    if(!_imageView) _imageView = [[UIImageView alloc] init];
  //  _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView sizeToFit];
    [_imageView setBackgroundColor:[UIColor blackColor]];
    return _imageView;
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize  = self.image ? self.image.size :  CGSizeZero;

//    self.imageView.frame = CGRectMake(10, 0, 50, 200);
//    self.imageView.bounds = CGRectMake(10, 0, 50, 200);
//    self.scrollView.contentSize  = CGSizeMake(50, 200);
}


-(UIImage *)image
{
    return self.imageView.image;
}

-(void)startDownloadinfImage
{
    NSURL *nsURl =[NSURL URLWithString:self.imageFile];
    NSData *data = [[NSData alloc] initWithContentsOfURL:nsURl];
    UIImage *image = [UIImage imageWithData:data];
    self.image = image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startDownloadinfImage];
    [self.scrollView addSubview:self.imageView];
}


@end
