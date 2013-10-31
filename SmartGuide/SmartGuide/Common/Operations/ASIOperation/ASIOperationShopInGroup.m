//
//  ASIOperaionShopInGroup.m
//  SmartGuide
//
//  Created by XXX on 7/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopInGroup.h"
#import "Shop.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "ShopCatalog.h"

@implementation ASIOperationShopInGroup
@synthesize shops,values;

-(ASIOperationShopInGroup *)initWithIDCity:(int)idCity idUser:(int)idUser lat:(double)latitude lon:(double)longtitude page:(int)page sort:(enum SORT_BY)sort group:(NSString *)ids
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_IN_GROUP_POST)];
    self=[super initWithURL:_url];
    
    values=@[ids,@(idCity),@(idUser),@(latitude),@(longtitude),@(page),@(sort)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"group_list",@"city_id",@"user_id",@"user_lat",@"user_lng",@"page",@"sort_by"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dic in json)
    {
        Shop *shop = [Shop makeShopWithDictionaryShopInGroup:dic];
        [shops addObject:shop];
    }
    
    [[DataManager shareInstance] save];
    
}

@end