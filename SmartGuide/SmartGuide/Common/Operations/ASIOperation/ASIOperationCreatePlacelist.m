//
//  ASIOperationCreatePlacelist.m
//  SmartGuide
//
//  Created by MacMini on 15/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationCreatePlacelist.h"

@implementation ASIOperationCreatePlacelist
@synthesize values,message,status,idPlacelist;

-(ASIOperationCreatePlacelist *)initWithName:(NSString *)name desc:(NSString *)desc idShop:(NSString *)idShops userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_CREATE_PLACELIST)]];
    
    values=@[name,desc,idShops,@(userLat),@(userLng)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"name",@"description",@"idShops",@"userLat",@"userLng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    idPlacelist=0;
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        idPlacelist=[NSNumber numberWithObject:dict[@"idPlacelist"]];
    }
}

@end
