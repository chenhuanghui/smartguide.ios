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
@property (nonatomic, readonly) int idUser;
@property (nonatomic, readonly) bool isConnectedFacebook;
@property (nonatomic, readonly) NSString *avatar;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, strong) NSString *activeCode;

@end
