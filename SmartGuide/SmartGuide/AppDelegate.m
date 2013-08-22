//
//  AppDelegate.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "RootViewController.h"
#import "FacebookManager.h"
#import "SHKConfiguration.h"
#import "DefaultSHKConfigurator.h"
#import "SHKFacebook.h"

@interface SHKSmartGuildeConfig : DefaultSHKConfigurator

@end

@implementation SHKSmartGuildeConfig

-(NSString *)appName
{
    return @"SmartGuide";
}

-(NSString *)facebookAppId
{
    return FACEBOOK_APPID;
}

-(NSArray *)facebookReadPermissions
{
    return FACEBOOK_PERMISSION;
}

-(NSArray *)facebookWritePermissions
{
    return FACEBOOK_PERMISSION;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect rect=[[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:rect];
    // Override point for customization after application launch.
    //Setting AFHTTP
    
    SHKSmartGuildeConfig *config=[[SHKSmartGuildeConfig alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:config];
    
    SHKFacebook *fb=[[SHKFacebook alloc] init];
    [fb isAuthorized];
    
    [AFHTTPRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil]];
    
    [RootViewController startWithWindow:self.window];
    
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [SHKFacebook handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [SHKFacebook handleWillTerminate];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [SHKFacebook handleOpenURL:url];
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationPortrait|UIInterfaceOrientationPortraitUpsideDown;
}

@end
