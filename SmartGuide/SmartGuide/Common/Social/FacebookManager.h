//
//  FacebookManager.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareKit.h"
#import "SHKFacebook.h"
#import "ASIOperationFBProfile.h"
#import "OperationFBGetProfile.h"

@interface FacebookManager : NSObject<SHKFacebookDelegate,OperationURLDelegate,ASIOperationPostDelegate>

+(FacebookManager*) shareInstance;

-(void) login;
-(void)postText:(NSString *)text identity:(id) tag delegate:(id<SHKFacebookDelegate>) delegate;
-(void) postURL:(NSURL*) url title:(NSString*) title text:(NSString*) text;
-(void) postImage:(UIImage*) image text:(NSString*) text identity:(id) tag delegate:(id<SHKFacebookDelegate>) delegate;
-(bool) isAuthorized;
-(bool) isLogined;
-(bool) isAllowPost;

@end