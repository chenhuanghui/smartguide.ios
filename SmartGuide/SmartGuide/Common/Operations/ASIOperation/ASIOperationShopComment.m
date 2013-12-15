//
//  ASIShopComment.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopComment.h"
#import "Shop.h"
#import "ShopUserComment.h"

@implementation ASIOperationShopComment
@synthesize values,comments;

-(ASIOperationShopComment *)initWithIDShop:(int)idShop page:(int)page
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_COMMENTS)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    comments=[NSMutableArray array];
    if([self isNullData:json])
        return;
    
//    Shop *shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
    
    for(NSDictionary *dict in json)
    {
        
    }
    
    [[DataManager shareInstance] save];
}

@end
