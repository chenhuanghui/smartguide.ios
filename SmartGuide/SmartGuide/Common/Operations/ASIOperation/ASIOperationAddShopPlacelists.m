//
//  ASIOperationAddShopPlacelists.m
//  SmartGuide
//
//  Created by MacMini on 15/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationAddShopPlacelists.h"

@implementation ASIOperationAddShopPlacelists
@synthesize status,message,placelits;

-(ASIOperationAddShopPlacelists *)initWithIDShop:(int)idShop idPlacelists:(NSString *)idPlacelists userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_ADD_SHOP_PLACELISTS)]];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:idPlacelists forKey:@"idPlacelists"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    placelits=[NSMutableArray array];
    
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        NSArray *array=dict[@"placelists"];
        
        if(![array isNullData])
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
