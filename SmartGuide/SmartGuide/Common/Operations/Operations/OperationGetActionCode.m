//
//  OperationGetActionCode.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGetActionCode.h"

@implementation OperationGetActionCode
@synthesize isSuccess,message;

-(OperationGetActionCode *)initWithPhone:(NSString *)phone
{
    NSURL *url=[NSURL URLWithString:API_GET_ACTIVE_CODE(phone)];
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=json[0];
    isSuccess=[dict[@"result"] boolValue];
    message=dict[@"message"];
}

@end
