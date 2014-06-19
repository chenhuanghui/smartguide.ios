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
@synthesize comments,sortComment;

-(ASIOperationShopComment *)initWithIDShop:(int)idShop page:(int)page sort:(enum SORT_SHOP_COMMENT)sort
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_COMMENTS)];
    self=[super initPOSTWithURL:_url];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    comments=[NSMutableArray array];
    
    if([json isNullData])
        return;
    
    Shop *shop=[Shop shopWithIDShop:[self.keyValue[IDSHOP] integerValue]];
    
    switch ([self.keyValue[SORT] integerValue]) {
        case 0:
            sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
            break;
            
        case 1:
            sortComment=SORT_SHOP_COMMENT_TIME;
            break;
            
        default:
            sortComment=SORT_SHOP_COMMENT_TOP_AGREED;
            break;
    }
    
    int count=sortComment==SORT_SHOP_COMMENT_TIME?shop.timeCommentsObjects.count:shop.topCommentsObjects.count;

    for(NSDictionary *dict in json)
    {
        ShopUserComment *cmt=[ShopUserComment makeWithJSON:dict];
        cmt.sortOrder=@(count++);
        
        switch (sortComment) {
            case SORT_SHOP_COMMENT_TOP_AGREED:
                [shop addTopCommentsObject:cmt];
                break;
                
            case SORT_SHOP_COMMENT_TIME:
                [shop addTimeCommentsObject:cmt];
        }
        
        [comments addObject:cmt];
    }
    
    [[DataManager shareInstance] save];
}

@end
