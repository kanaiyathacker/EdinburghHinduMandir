//
//  RecipeSegmentControl.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import "RecipeSegmentControl.h"
#import "SegmentButtonView.h"
#import "CalendarData.h"
#import "DateUtil.h"

#import <QuartzCore/QuartzCore.h>

@interface RecipeSegmentControl ()

@property (nonatomic, strong) NSArray *segmentButtons;

- (void)setUpSegmentButtons;

@end

@implementation RecipeSegmentControl

@synthesize segmentButtons = _segmentButtons;

- (id)init {
    self = [super init];
    
    if (self) {
        // Set up layer in order to clip any drawing that is done outside of self.bounds
        self.layer.masksToBounds = YES;

        // Set up segment buttons
      //  [self setUpSegmentButtons];

        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0,
                [[UIScreen mainScreen] applicationFrame].size.width,
                600.00);
        
        NSLog(@"frame size - %f" , [[UIScreen mainScreen] applicationFrame].size.width);
        NSLog(@"frame size - %f" , [[UIScreen mainScreen] applicationFrame].size.height);
    }
    return self;
}

-(void)initial:(NSArray *)title {
    // Set up segment buttons
    [self setUpSegmentButtons:title];
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0,
                            [[UIScreen mainScreen] applicationFrame].size.width,
                            600.00);

}

- (void)setUpSegmentButtons:(NSArray *)title {
    SegmentButtonView *segment1 = [[SegmentButtonView alloc] initWithTitle:title[0]
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_1.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_1_active.png"]
            delegate:self index:100];
    
    SegmentButtonView *segment2 = [[SegmentButtonView alloc] initWithTitle:title[1]
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_2.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_2_active.png"]
            delegate:self index:101];
    SegmentButtonView *segment3 = [[SegmentButtonView alloc] initWithTitle:title[2]
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_3.png"]
            highlightImage:[UIImage imageNamed:@"recipe_tab_3_active.png"]
            delegate:self index:102];

   
    
    SegmentButtonView *segment4 = [[SegmentButtonView alloc] initWithTitle:title[3]
                                                               normalImage:[UIImage imageNamed:@"recipe_tab_1.png"]
                                                            highlightImage:[UIImage imageNamed:@"recipe_tab_1_active.png"]
                                                                  delegate:self index:103];
    
    
    
    segment1.frame = CGRectOffset(segment1.frame, 0, 0);
    segment2.frame = CGRectOffset(segment2.frame, segment1.frame.size.width, 0);
    segment3.frame = CGRectOffset(segment3.frame, segment1.frame.size.width + segment2.frame.size.width, 0);
    segment4.frame = CGRectOffset(segment4.frame, 1+segment1.frame.size.width + segment2.frame.size.width+ segment3.frame.size.width , 0);
    
    // Highlight the first segment
    [segment1 setHighlighted:YES animated:NO];
    
    [self addSubview:segment1];
    [self addSubview:segment2];
    [self addSubview:segment3];
    [self addSubview:segment4];
    
    self.segmentButtons = [NSArray arrayWithObjects:segment1, segment2, segment3,segment4, nil];
}

#pragma mark - SegmentButtonViewDelegate

- (void)segmentButtonHighlighted:(SegmentButtonView *)highlightedSegmentButton {
    for (SegmentButtonView *segmentButton in self.segmentButtons) {
        if ([segmentButton isEqual:highlightedSegmentButton]) {
            [segmentButton setHighlighted:YES animated:YES];
            NSLog(@"helo - %d " , [[segmentButton subviews][1] tag]);
            
            
            [self.openingTimeButtonTabViewController selectedIndex:[[segmentButton subviews][1] tag]];
            
        } else {
            [segmentButton setHighlighted:NO animated:YES];
        }
    }
    
}
                       


@end
