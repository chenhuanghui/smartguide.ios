//
//  OperationGetActionCode.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationGetActionCode : OperationURL

-(OperationGetActionCode*) initWithPhone:(NSString*) phone;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) NSString *message;

@end
