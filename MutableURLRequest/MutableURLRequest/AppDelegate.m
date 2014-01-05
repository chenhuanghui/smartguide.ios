//
//  AppDelegate.m
//  MutableURLRequest
//
//  Created by MacMini on 05/01/2014.
//  Copyright (c) 2014 MacMini. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()<NSURLConnectionDataDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev2.smartguide.vn/user/activation"]];
    
//    [request addValue:@"841225372227" forHTTPHeaderField:@"phone"];
    NSData *data=[@"phone=841225372227" dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    
    [conn start];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    lbl.backgroundColor=[UIColor blackColor];
    lbl.textColor=[UIColor whiteColor];
    
    [self.window addSubview:lbl];
    
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(!_data)
        _data=[[NSMutableData alloc] init];
    
    [_data appendData:data];
    
    NSLog(@"%@ %@",connection.currentRequest,connection.originalRequest);
    lbl.text=[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finish %@ %@",connection.currentRequest,connection.originalRequest);
    
    lbl.text=[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
