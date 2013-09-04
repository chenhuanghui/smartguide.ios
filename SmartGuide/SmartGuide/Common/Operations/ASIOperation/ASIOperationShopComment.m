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
    
    Shop *shop=[Shop shopWithIDShop:[[self.values objectAtIndex:0] integerValue]];
    
    for(NSDictionary *dict in json)
    {
        ShopUserComment *comment=[ShopUserComment insert];
        comment.shop=shop;
        comment.idShop=shop.idShop;
        comment.user=[NSString stringWithStringDefault:[dict objectForKey:@"user"]];
        comment.comment=[NSString stringWithStringDefault:[dict objectForKey:@"comment"]];
        comment.avatar=[NSString stringWithStringDefault:[dict objectForKey:@"avatar"]];
        comment.time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
        comment.fulltime=[NSString stringWithStringDefault:[dict objectForKey:@"fulltime"]];
        
        [comments addObject:comment];
        [shop addShopUserCommentsObject:comment];
    }
    
    [[DataManager shareInstance] save];
}

@end
