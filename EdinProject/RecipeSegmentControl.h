//
//  RecipeSegmentControl.h
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//


#import "SegmentButtonView.h"
#import "OpeningTimeButtonTabViewController.h"

@interface RecipeSegmentControl : UIView <SegmentButtonViewDelegate>
-(void)initial:(NSArray *)title;
@property (nonatomic , strong)NSArray *dataOfArray;
@property (nonatomic , strong)OpeningTimeButtonTabViewController *openingTimeButtonTabViewController;

@end
