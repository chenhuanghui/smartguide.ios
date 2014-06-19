//
//  OperationRefreshToken.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationRefreshToken : ASIOperationPost
{
}

-(OperationRefreshToken*) initWithClientID:(NSString*) clientID secretID:(NSString*) secretID refreshToken:(NSString*) refreshToken;

@property (nonatomic, readonly) NSString* accessToken;
@property (nonatomic, readonly) NSString* expiresIn;
@property (nonatomic, readonly) NSString* refreshToken;

@end