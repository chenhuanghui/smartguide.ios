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
@synthesize values,comments,sortComment;

-(ASIOperationShopComment *)initWithIDShop:(int)idShop page:(int)page sort:(enum SORT_SHOP_COMMENT)sort
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_COMMENTS)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(page),@(sort)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"page",@"sort"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    comments=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    Shop *shop=[Shop shopWithIDShop:[values[0] integerValue]];
    
    int count=0;
    
    switch ([values[2] integerValue]) {
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
