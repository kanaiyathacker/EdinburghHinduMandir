//
//  GalleryPhotoViewController.m
//  Hindu Mandir
//
//  Created by kanaiyathacker on 15/07/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "GalleryPhotoViewController.h"
#import "PageContentViewController.h"

@interface GalleryPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@end
static int count=0;
@implementation GalleryPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor colorWithRed:(153/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
   // [pageControl sizeToFit];
    
    
    int count=0;
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    NSLog(@"startWalkthrough %@" , sender);
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    NSLog(@"viewControllerAtIndex %ul " , index);
        GalleryData *data = self.galleryData[index];
    if (([self.galleryData count] == 0) || (index >= [self.galleryData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];

    NSLog(@"Gallery data - %@" , data);
    // NSString *imageName = [data imageUrl];
    // self.imageVIew.animationDuration
//    self.imageVIew.image =[UIImage imageWithData:data.imageData];

    pageContentViewController.imageFile = [data imageUrl];
    pageContentViewController.titleText = [data title];
    pageContentViewController.pageIndex = index;
      NSLog(@"viewControllerAtIndex---- %ul " , index);
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.galleryData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.galleryData count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
@end
