//
//  OperationVerifyActiveCode.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationVerifyActiveCode : OperationURL

-(OperationVerifyActiveCode*) initWithPhone:(NSString*) phone aciveCode:(NSString*) activeCode;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) User *user;
@property (nonatomic, strong) NSString *activeCode;

@end
