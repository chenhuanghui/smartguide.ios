//
//  OperationShopInGroup.m
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationShopInGroup.h"
#import "Shop.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"

@implementation OperationShopInGroup
@synthesize shops;

-(OperationShopInGroup *)initWithIDUser:(int)idUser idCity:(int)idCity idGroup:(int)idGroup pageIndex:(int)page userLatitude:(float)lat userLongtitude:(float)longtitude
{
    NSURL *url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_IN_GROUP(idUser,idCity,idGroup,page,lat,longtitude))];
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSMutableArray *array=[NSMutableArray array];
    for(NSDictionary *dic in json)
    {
        int idShop=[dic integerForKey:@"id"];
        Shop *shop = [Shop shopWithIDShop:idShop];
        if(!shop)
        {
            shop=[Shop insert];
            shop.idShop=[NSNumber numberWithInt:idShop];
        }
        
        shop.name=[dic objectForKey:@"name"];
        shop.shop_lat=[dic objectForKey:@"shop_lat"];
        shop.shop_lng=[dic objectForKey:@"shop_lng"];
        shop.distance=[dic objectForKey:@"distance"];
        shop.logo=[dic objectForKey:@"logo"];
        shop.desc=[dic objectForKey:@"description"];
        shop.address=[dic objectForKey:@"address"];
        
        NSDictionary *dicInner=[dic objectForKey:@"promotion_detail"];
        
        PromotionDetail *promotion=shop.promotionDetail;
        
        if(!promotion)
        {
            promotion=[PromotionDetail insert];
            promotion.shop=shop;
            shop.promotionDetail=promotion;
        }
        
        promotion.promotionType=[dicInner objectForKey:@"promotion_type"];
        promotion.sgp=[dicInner objectForKey:@"sgp"];
        promotion.cost=[dicInner objectForKey:@"cost"];
        promotion.beginDate=[dicInner objectForKey:@"begin_date"];
        promotion.endDate=[dicInner objectForKey:@"end_data"];
        
        [promotion removeRequires:promotion.requires];
        
        dicInner=[dicInner objectForKey:@"array_required"];
        
        for(NSDictionary *childDicInner in dicInner)
        {
            PromotionRequire *require=[PromotionRequire insert];
            
            require.promotion=promotion;
            require.sgpRequired=[childDicInner objectForKey:@"required"];
            require.content=[childDicInner objectForKey:@"content"];
        }
        
        [array addObject:[NSNumber numberWithInt:idShop]];
    }
    
    [[DataManager shareInstance] save];
    
    shops=[Shop queryShop:[NSPredicate predicateWithFormat:@"%K IN %@",Shop_IdShop,array]];
}

@end