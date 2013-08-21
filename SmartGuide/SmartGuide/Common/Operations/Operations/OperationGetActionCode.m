//
//  OperationGetActionCode.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGetActionCode.h"

@implementation OperationGetActionCode
@synthesize isSuccess;

-(OperationGetActionCode *)initWithPhone:(NSString *)phone
{
    NSURL *url=[NSURL URLWithString:API_GET_ACTIVE_CODE(phone)];
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=[[[json objectAtIndex:0] objectForKey:@"result"] boolValue];
}

@end
