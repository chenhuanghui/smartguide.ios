//
//  ASIOperationAddShopPlacelists.m
//  SmartGuide
//
//  Created by MacMini on 15/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationAddShopPlacelists.h"

@implementation ASIOperationAddShopPlacelists
@synthesize values,status,message,placelits;

-(ASIOperationAddShopPlacelists *)initWithIDShop:(int)idShop idPlacelists:(NSString *)idPlacelists userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_ADD_SHOP_PLACELISTS)]];
    
    values=@[@(idShop),idPlacelists,@(userLat),@(userLng)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"idPlacelists",@"userLat",@"userLng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    placelits=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        NSArray *array=dict[@"placelists"];
        
        if(![self isNullData:array])
        {
            for(NSDictionary *place in array)
            {
                int idPlace=[[NSNumber numberWithObject:place[@"idPlacelist"]] integerValue];
                
                UserPlacelist *placelist=[UserPlacelist userPlacelistWithIDPlacelist:idPlace];
                
                if(placelist)
                {
                    placelist.numOfShop=[NSString stringWithStringDefault:dict[@"numOfShop"]];
                    placelist.idShops=[NSString stringWithStringDefault:dict[@"idShops"]];
                    
                    [placelits addObject:placelist];
                }
            }
            
            [[DataManager shareInstance] save];
        }
    }
}

@end
