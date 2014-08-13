//
//  EdinProjectAppDelegate.m
//  EdinProject
//
//  Created by kanaiyathacker on 28/06/2014.
//  Copyright (c) 2014 VaioTech. All rights reserved.
//

#import "EdinProjectAppDelegate.h"
#import "DateUtil.h"
#import "LeftMenuViewController.h"
#import "MenuItemViewController.h"
#import "EdinProjectViewController.h"
#import "AccessData.h"
#import "SlideNavigationController.h"



@interface EdinProjectAppDelegate ()
@property (strong, nonatomic) NSTimer *updateTimer;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;
@property (nonatomic , strong)AccessData *accessData;

@end

@implementation EdinProjectAppDelegate


-(AccessData *) accessData
{
    if(!_accessData) _accessData = [[AccessData alloc] init];
    return _accessData;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Let the device know we want to receive push notifications
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    
    if([[self accessData ] connected] == YES) {
        
        
        
        
        dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
        dispatch_async(myQueue, ^{
            UINavigationController *controller = self.window.rootViewController;
            
            if(controller) {
                NSLog(@"applicationWillEnterForeground %@ " , [controller viewControllers][0]);
                EdinProjectViewController *edinProjectViewController=[controller viewControllers][0];
                [edinProjectViewController setOpeningTime];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                
            });
        });
        
        
        
        
        
    }
    
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
        NSString *deviceTokenStr = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
        
        NSLog(@"Device Token: %@", deviceTokenStr);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        NSString *url = [NSString stringWithFormat:@"http://devicetokenapplicai-env.elasticbeanstalk.com/device/%@/ios" ,deviceTokenStr ];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSLog(@"URL -- %@" , url);
        [[NSURLConnection alloc]initWithRequest:request delegate:Nil];
            dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });

    
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
}

@end
