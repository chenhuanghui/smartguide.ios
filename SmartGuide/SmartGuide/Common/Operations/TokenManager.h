//
//  TokenManager.h
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenManager : NSObject
{
}

+(TokenManager*) shareInstance;

-(void) checkToken;
-(bool) isRefreshingToken;
-(void) refresh;

-(void) useDefaultToken;

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *activeCode;
@property (nonatomic, strong) NSString *phone;

@end
