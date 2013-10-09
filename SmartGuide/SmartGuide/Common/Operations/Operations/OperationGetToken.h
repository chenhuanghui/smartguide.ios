//
//  OperationGetToken.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationGetToken : OperationURL

-(OperationGetToken*) initWithPhone:(NSString*) phone activeCode:(NSString*) activeCode;

@property (nonatomic, readonly) NSString* accessToken;
@property (nonatomic, readonly) NSString* expiresIn;
@property (nonatomic, readonly) NSString* refreshToken;

@end
