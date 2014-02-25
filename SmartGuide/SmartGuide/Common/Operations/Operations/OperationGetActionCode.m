//
//  OperationGetActionCode.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGetActionCode.h"

@implementation OperationGetActionCode
@synthesize isSuccess,message,phone;

-(OperationGetActionCode *)initWithPhone:(NSString *)_phone fScreen:(NSString *)fScreen fData:(NSDictionary *)fData
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:_phone forKey:@"phone"];
    
    if(fScreen.length>0)
    {
        [dict setObject:fScreen forKey:@"fScreen"];
        
        NSString *fDataString=[fData jsonString];
        if(fDataString.length>0)
            [dict setObject:[fDataString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"fData"];
    }
    
    self=[super initWithRouter:SERVER_IP_MAKE(API_GET_ACTIVE_CODE) params:dict];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=false;
    message=@"";
    phone=self.params[@"phone"];
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    isSuccess=[[NSNumber numberWithObject:dict[@"result"]] boolValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
}

@end
