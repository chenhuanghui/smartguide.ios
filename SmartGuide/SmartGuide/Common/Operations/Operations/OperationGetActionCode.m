//
//  OperationGetActionCode.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGetActionCode.h"

@implementation OperationGetActionCode

-(OperationGetActionCode *)initWithPhone:(NSString *)phone
{
    self=[super initGETWithRouter:SERVER_IP_MAKE_URL(API_GET_ACTIVE_CODE)];
    
    [self.keyValue setObject:phone forKey:@"phone"];
    
    return self;
}

-(void)onFinishLoading
{
    self.isSuccess=@(false);
    self.message=@"";
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    self.isSuccess=[NSNumber makeNumber:dict[@"result"]];
    self.message=[NSString makeString:dict[@"message"]];
}

-(NSString *)phone
{
    return self.keyValue[@"phone"]?:@"";
}

@end
