//
//  ASIOperationPostComment.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPostComment.h"
#import "ShopUserComment.h"
#import "Shop.h"

@implementation ASIOperationPostComment

-(ASIOperationPostComment *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng comment:(NSString *)comment sort:(enum SORT_SHOP_COMMENT)sort
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_POST_COMMENT)];
    
    self=[super initPOSTWithURL:_url];

    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:comment forKey:@"comment"];
    [self.storeData setObject:@(sort) forKey:SORT];
    
    return self;
}

-(enum SORT_SHOP_COMMENT)sortComment
{
    switch ([self.storeData[SORT] integerValue]) {
        case SORT_SHOP_COMMENT_TIME:
            return SORT_SHOP_COMMENT_TIME;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            return SORT_SHOP_COMMENT_TOP_AGREED;
            
        default:
            return SORT_SHOP_COMMENT_TOP_AGREED;
    }
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;

    NSDictionary *dict=json[0];
    
    self.status=[NSNumber makeNumber:dict[@"status"]];
    self.message=[NSString makeString:dict[@"message"]];
    
    if(self.status.integerValue==1)
    {
        self.idComment=[NSNumber makeNumber:dict[@"idComment"]];
        self.time=[NSString makeString:dict[@"time"]];
        
        int idShop=[self.keyValue[IDSHOP] integerValue];
        Shop *shop=[Shop shopWithIDShop:idShop];
        
        if(!shop)
            return;
        
        self.userComment=[ShopUserComment insert];

        self.userComment.idComment=self.idComment;
        self.userComment.username=[NSString makeString:[DataManager shareInstance].currentUser.name];
        self.userComment.comment=self.keyValue[@"comment"];
        self.userComment.avatar=[DataManager shareInstance].currentUser.avatar;
        self.userComment.numOfAgree=@"0";
        self.userComment.time=self.time;
        self.userComment.agreeStatus=@(0);
        
        int sortOrder=0;
        
        switch ([self sortComment]) {
            case SORT_SHOP_COMMENT_TIME:
                
                if(shop.timeCommentsObjects.count>0)
                    sortOrder=[[shop.timeCommentsObjects valueForKeyPath:[NSString stringWithFormat:@"@min.%@",ShopUserComment_SortOrder]] integerValue]-1;
                
                self.userComment.sortOrder=@(sortOrder);
                [shop addTimeCommentsObject:self.userComment];
                
                break;
                
            case SORT_SHOP_COMMENT_TOP_AGREED:
                
                if(shop.topCommentsObjects.count>0)
                    sortOrder=[[shop.topCommentsObjects valueForKeyPath:[NSString stringWithFormat:@"@min.%@",ShopUserComment_SortOrder]] integerValue]-1;
                
                self.userComment.sortOrder=@(sortOrder);
                [shop addTopCommentsObject:self.userComment];
                
                break;
        }
        
        [[DataManager shareInstance] save];
    }
    
}
@end
