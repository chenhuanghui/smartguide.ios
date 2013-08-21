//
//  OperationRefreshToken.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationRefreshToken : OperationURL<OperationURLDelegate>
{
    void(^_refreshCompleted)(NSString *accessToken, NSString *refreshToken);
}

+(void) refreshTokenWithClientID:(NSString*) clientID secretID:(NSString*) secretID refreshToken:(NSString*) refresh onCompleted:(void(^)(NSString* accessToken, NSString *refreshToken)) onCompleted;
-(OperationRefreshToken*) initWithClientID:(NSString*) clientID secretID:(NSString*) secretID refreshToken:(NSString*) refreshToken;

-(void) setRefreshCompleted:(void(^)(NSString *accessToken, NSString *refreshToken)) completed;

@property (nonatomic, readonly) NSString* accessToken;
@property (nonatomic, readonly) NSString* expiresIn;
@property (nonatomic, readonly) NSString* refreshToken;

@end