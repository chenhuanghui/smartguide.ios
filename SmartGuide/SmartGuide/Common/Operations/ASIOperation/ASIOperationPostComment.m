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
@synthesize status,message,time,idComment,sortComment,userComment;

-(ASIOperationPostComment *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng comment:(NSString *)comment sort:(enum SORT_SHOP_COMMENT)sort
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_POST_COMMENT)];
    
    self=[super initWithURL:_url];

    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:comment forKey:@"comment"];
    [self.keyValue setObject:@(sort) forKey:SORT];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    int sort=[self.keyValue[SORT] integerValue];
    NSDictionary *dict=json[0];
    
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        idComment=[[NSNumber numberWithObject:dict[@"idComment"]] integerValue];
        time=[NSString stringWithStringDefault:dict[@"time"]];
        
        switch (sort) {
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
        
        int idShop=[self.keyValue[IDSHOP] integerValue];
        Shop *shop=[Shop shopWithIDShop:idShop];
        
        if(!shop)
            return;
        
        userComment=[ShopUserComment insert];

        userComment.idComment=@(idComment);
        userComment.username=[NSString stringWithStringDefault:[DataManager shareInstance].currentUser.name];
        userComment.comment=self.keyValue[@"comment"];
        userComment.avatar=[DataManager shareInstance].currentUser.avatar;
        userComment.numOfAgree=@"0";
        userComment.time=time;
        userComment.agreeStatus=@(0);
        
        int sortOrder=0;
        
        switch (sortComment) {
            case SORT_SHOP_COMMENT_TIME:
                
                if(shop.timeCommentsObjects.count>0)
                    sortOrder=[[shop.timeCommentsObjects valueForKeyPath:[NSString stringWithFormat:@"@min.%@",ShopUserComment_SortOrder]] integerValue]-1;
                
                userComment.sortOrder=@(sortOrder);
                [shop addTimeCommentsObject:userComment];
                break;
                
            case SORT_SHOP_COMMENT_TOP_AGREED:
                
                if(shop.topCommentsObjects.count>0)
                    sortOrder=[[shop.topCommentsObjects valueForKeyPath:[NSString stringWithFormat:@"@min.%@",ShopUserComment_SortOrder]] integerValue]-1;
                
                userComment.sortOrder=@(sortOrder);
                
                [shop addTopCommentsObject:userComment];
                break;
        }
        
        [[DataManager shareInstance] save];
    }
    
}
@end
