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
@synthesize values,shops,name;

-(ASIOperationSearchShop *)initWithShopName:(NSString *)_name idUser:(int)idUser lat:(double)lat lon:(double)lon page:(int)page
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_SEARCH)];
    self=[super initWithURL:_url];
    
    values=@[_name,@(idUser),@(lat),@(lon),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_name",@"user_id",@"user_lat",@"user_lng",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    name=[NSString stringWithString:[values objectAtIndex:0]];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        Shop *shop=[Shop makeShopWithDictionaryShopInGroup:dict];
        
        [shops addObject:shop];
    }
    
    [[DataManager shareInstance] save];
}

@end
