//
//  ASIOperationCreatePlacelist.m
//  SmartGuide
//
//  Created by MacMini on 15/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationCreatePlacelist.h"

@implementation ASIOperationCreatePlacelist
@synthesize message,status,placelist;

-(ASIOperationCreatePlacelist *)initWithName:(NSString *)name desc:(NSString *)desc idShop:(NSString *)idShops userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_CREATE_PLACELIST)]];
    
    [self.keyValue setObject:name forKey:@"name"];
    [self.keyValue setObject:desc forKey:@"description"];
    [self.keyValue setObject:idShops forKey:@"idShops"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber makeNumber:dict[@"status"]] integerValue];
    message=[NSString makeString:dict[@"message"]];
    
    if(status==1)
    {
        placelist=[UserPlacelist makeWithDictionary:dict[@"placelist"]];
        [[DataManager shareInstance] save];
    }
}

@end
