//
//  OperationVerifyActiveCode.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUserCheck : ASIOperationPost

-(ASIOperationUserCheck*) initWithPhone:(NSString*) phone aciveCode:(NSString*) activeCode;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) NSString *activeCode;
@property (nonatomic, readonly) NSString *refreshToken;
@property (nonatomic, readonly) NSString *accessToken;

@end
