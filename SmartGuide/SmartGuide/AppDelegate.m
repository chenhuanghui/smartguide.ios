//
//  AppDelegate.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//
//test subversion 12345

#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "FacebookManager.h"
#import "GooglePlusManager.h"
#import "Flurry.h"
#import "GUIManager.h"
#import "SDWebImageManager.h"
#import "NotificationManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NotificationManager shareInstance] receiveLaunchNotification:launchOptions];
    
    CGRect rect=[[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:rect];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isCleanDisk"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@(true) forKey:@"isCleanDisk"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[SDWebImageManager sharedManager].imageCache clearDisk];
    }
    
    [[GUIManager shareInstance] startupWithWindow:self.window];
    
    [[NotificationManager shareInstance] registerRemoteNotificaion];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
//    NSString *str = [NSString stringWithFormat:@"Token: %@", deviceToken];
//    NSLog(@"%@", str);
    [[NotificationManager shareInstance] receiveDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@",err);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[NotificationManager shareInstance] receiveRemoteNotification:userInfo];
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FacebookManager handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FacebookManager handleWillTerminate];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    bool googlePlusHandle=[GPPURLHandler handleURL:url
           sourceApplication:sourceApplication
                  annotation:annotation];
    
    if(googlePlusHandle)
        return true;
    
    return [FacebookManager handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown;
}

@end