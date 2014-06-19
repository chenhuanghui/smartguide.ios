//
//  OperationGetActionCode.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationGetActionCode : ASIOperationPost

-(OperationGetActionCode*) initWithPhone:(NSString*) phone;

-(NSString*) phone;

@property (nonatomic, strong) NSNumber *isSuccess;
@property (nonatomic, strong) NSString *message;

@end
