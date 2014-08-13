//
//  OpeningTImeTabViewController.h
//  Hindu Mandir
//
//  Created by kanaiyathacker on 02/08/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpeningTImeTabViewController : UIViewController  <UITabBarControllerDelegate>
@property (nonatomic, strong) NSString *openingTime;
@property (nonatomic , strong)NSArray *dataOfArray;
@property (weak, nonatomic) IBOutlet UILabel *openingTimeFirst;
-(NSString *) formatTimeWithStart:(NSString *)start andEnd:(NSString *)end;
@property (weak, nonatomic) IBOutlet UITextView *detailsFirst;
@end
