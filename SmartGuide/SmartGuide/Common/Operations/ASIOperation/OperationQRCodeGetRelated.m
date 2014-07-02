//
//  OperationQRCodeGetRelated.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationQRCodeGetRelated.h"

@implementation OperationQRCodeGetRelated

-(OperationQRCodeGetRelated *)initWithCode:(NSString *)code type:(enum QRCODE_RELATED_TYPE)type page:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithRouter:SERVER_API_URL_MAKE(API_QRCODE_GET_RELATED)];
    
    [self.keyValue setObject:code forKey:@"code"];
    [self.keyValue setObject:@(type) forKey:@"type"];
    [self.keyValue setObject:@(page) forKey:@"page"];
    [self.keyValue setObject:@(5) forKey:@"pageSize"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.placelists=[NSMutableArray new];
    self.shops=[NSMutableArray new];
    self.promotions=[NSMutableArray new];
    self.order=[NSArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    NSDictionary *dictJson=json[0];
    
    if([dictJson[@"relatedShops"] hasData])
    {
        for(NSDictionary *dict in dictJson[@"relatedShops"])
        {
            [self.shops addObject:[RelatedShop makeWithDictionary:dict]];
        }
    }
    
    if([dictJson[@"relatedPromotions"] hasData])
    {
        for(NSDictionary *dict in dictJson[@"relatedPromotions"])
        {
            [self.promotions addObject:[RelatedPromotion makeWithDictionary:dict]];
        }
    }
    
    if([dictJson[@"relatedPlacelists"] hasData])
    {
        for(NSDictionary *dict in dictJson[@"relatedPlacelists"])
        {
            [self.placelists addObject:[RelatedPlacelist makeWithDictionary:dict]];
        }
    }
    
    if([dictJson[@"order"] hasData])
        self.order=[NSArray makeArray:dictJson[@"order"]];
}

@end

@implementation RelatedShop

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.descHeight=@(-1);
    }
    return self;
}

+(RelatedShop *)makeWithDictionary:(NSDictionary *)dict
{
    RelatedShop *obj=[RelatedShop new];
    
    obj.idShop=[NSNumber numberWithObject:dict[@"idShop"]];
    obj.shopName=[NSString makeString:dict[@"shopName"]];
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    
    return obj;
}

@end

@implementation RelatedPromotion

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.descHeight=@(-1);
    }
    return self;
}

+(RelatedPromotion *)makeWithDictionary:(NSDictionary *)dict
{
    RelatedPromotion *obj=[RelatedPromotion new];
    
    obj.idShops=[NSArray makeArray:dict[@"idShops"]];
    obj.promotionName=[NSString makeString:dict[@"promotionName"]];
    obj.logo=[NSString makeString:dict[@"logo"]];
    obj.time=[NSString makeString:dict[@"time"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    
    return obj;
}

@end

@implementation RelatedPlacelist

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.descHeight=@(-1);
    }
    return self;
}

+(RelatedPlacelist*) makeWithDictionary:(NSDictionary *)dict
{
    RelatedPlacelist *obj=[RelatedPlacelist new];
    
    obj.placelistID=[NSNumber numberWithObject:dict[@"placelistID"]];
    obj.placelistName=[NSString makeString:dict[@"placelistName"]];
    obj.authorAvatar=[NSString makeString:dict[@"authorAvatar"]];
    obj.desc=[NSString makeString:dict[@"description"]];
    
    return obj;
}

@end