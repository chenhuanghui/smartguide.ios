//
//  ASIOperationSearch.m
//  SmartGuide
//
//  Created by XXX on 8/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationSearchShop.h"
#import "Shop.h"

@implementation ASIOperationSearchShop
@synthesize values,shops,keyword,groups,promotionFilter,sortType;

-(ASIOperationSearchShop *) initWithKeyword:(NSString *)_keyword groups:(NSString *)_groups idUser:(int)idUser lat:(double)lat lon:(double)lon page:(int)page promotionFilter:(enum SHOP_PROMOTION_FILTER_TYPE)_promotionFilter sortType:(enum SORT_BY)_sortType
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_SEARCH)];
    self=[super initWithURL:_url];
    
    values=@[_keyword,_groups,@(_sortType),@(_promotionFilter),@(lat),@(lon),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"keyWords",@"groups",@"sortType",SHOP_PROMOTION_FILTER_KEY,@"userLat",@"userLng",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    keyword=[values[0] copy];
    groups=[values[1] copy];
    sortType=[values[2] integerValue];
    promotionFilter=[values[3] integerValue];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        
    }
    
    [[DataManager shareInstance] save];
}

@end
