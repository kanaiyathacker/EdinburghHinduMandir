//
//  MyCalendar.h
//  EdinProject
//
//  Created by kanaiyathacker on 29/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCalendar : NSObject
+ (void)addEventAt:(NSDate*)eventDate withEndDate:(NSDate *)endDate withTitle:(NSString*)title inLocation:(NSString*)location;
+(BOOL) isEventStoredInCal:(NSDate *)start end:(NSDate *)end title:(NSString *)title;
+(NSString *) getEventID:(NSDate *)start end:(NSDate *)end title:(NSString *)title;

@end
