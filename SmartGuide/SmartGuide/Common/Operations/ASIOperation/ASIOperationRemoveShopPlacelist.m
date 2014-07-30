//
//  ASIOperationRemoveShopPlacelist.m
//  Infory
//
//  Created by XXX on 4/8/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationRemoveShopPlacelist.h"

@implementation ASIOperationRemoveShopPlacelist

-(ASIOperationRemoveShopPlacelist *)initWithIDPlacelist:(int)idPlace idShops:(NSString*)idShops userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_REMOVE_SHOP_PLACELISTS)];
    
    [self.keyValue setObject:@(idPlace) forKey:IDPLACELIST];
    [self.keyValue setObject:idShops forKey:@"idShops"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.status=0;
    self.message=@"";
    self.numOfShop=@"";
    self.idShops=self.keyValue[@"idShops"];
    self.idPlace=self.keyValue[IDPLACELIST];
    
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    self.status=[[NSNumber makeNumber:dict[STATUS]] integerValue];
    self.message=[NSString makeString:dict[MESSAGE]];
    
    if(self.status==1)
    {
        ShopList *shop=[ShopList shopListWithIDShop:self.idShop.integerValue];
        
        if(shop)
        {
            [[DataManager shareInstance].managedObjectContext deleteObject:shop];
            [[DataManager shareInstance] save];
        }
        self.numOfShop=[NSString makeString:dict[@"numOfShop"]];
    }
}

-(NSNumber *)idShop
{
    if(self.idShops.length>0)
    {
        return @([[self.idShops componentsSeparatedByString:@","][0] integerValue]);
    }
    
    return nil;
}

-(ShopList *)shopList
{
    NSNumber *idShop=[self idShop];
    
    if(idShop)
    {
        return [ShopList shopListWithIDShop:[idShop integerValue]];
    }
    
    return nil;
}

@end
