//
//  MyCalendar.m
//  EdinProject
//
//  Created by kanaiyathacker on 29/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "MyCalendar.h"
#import <EventKit/EventKit.h>

@implementation MyCalendar

+ (void)addEventAt:(NSDate*)eventDate withEndDate:(NSDate *)endDate withTitle:(NSString*)title inLocation:(NSString*)location;
{
    EKEventStore *eventStore=[[EKEventStore alloc] init];
    EKEvent *addEvent=[EKEvent eventWithEventStore:eventStore];
    addEvent.title=title;
    addEvent.startDate=eventDate;
//    addEvent.endDate=[addEvent.startDate dateByAddingTimeInterval:600];
    addEvent.endDate=endDate;
    addEvent.location=location;
    if([self checkIsDeviceVersionHigherThanRequiredVersion:@"6.0"]) {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted){
                [addEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
                addEvent.alarms=[NSArray arrayWithObject:[EKAlarm alarmWithAbsoluteDate:addEvent.startDate]];
                [eventStore saveEvent:addEvent span:EKSpanThisEvent error:nil];
                
            }else {
//                [[UIAlertView alloc ]init];
                //----- codes here when user NOT allow your app to access the calendar.
            }
        }];
        
    }else {
        [addEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
         addEvent.alarms=[NSArray arrayWithObject:[EKAlarm alarmWithAbsoluteDate:addEvent.startDate]];
         [eventStore saveEvent:addEvent span:EKSpanThisEvent error:nil];
    }
    

}

+(BOOL) isEventStoredInCal:(NSDate *)start end:(NSDate *)end title:(NSString *)title
{
    // Create the predicate from the event store's instance method
    EKEventStore *store=[[EKEventStore alloc] init];
    
    NSPredicate *predicate = [store predicateForEventsWithStartDate:start
                              
                                                            endDate:end
                              
                                                          calendars:nil];
    
    
    
    // Fetch all events that match the predicate
    BOOL retVal = NO;
    NSArray *events = [store eventsMatchingPredicate:predicate];
    for(EKEvent *curr in events) {
        
        if([title isEqualToString:curr.title]) {
            retVal = YES;
        }
    }
    return retVal;
}

+ (BOOL)checkIsDeviceVersionHigherThanRequiredVersion:(NSString *)requiredVersion
{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    if ([currSysVer compare:requiredVersion options:NSNumericSearch] != NSOrderedAscending)
    {
        return YES;
    }
    
    return NO;
}
@end
