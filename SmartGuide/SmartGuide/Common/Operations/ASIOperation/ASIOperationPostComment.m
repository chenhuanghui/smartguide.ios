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
@synthesize values,status,message,time,idComment,sortComment,userComment;

-(ASIOperationPostComment *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng comment:(NSString *)comment sort:(enum SORT_SHOP_COMMENT)sort
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_POST_COMMENT)];
    
    self=[super initWithURL:_url];

    values=@[@(idShop),@(userLat),@(userLng),comment,@(sort)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"userLat",@"userLng",@"comment",@"sort"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    int sort=[values[4] integerValue];
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
        
        int idShop=[values[0] integerValue];
        Shop *shop=[Shop shopWithIDShop:idShop];
        
        if(!shop)
            return;
        
        userComment=[ShopUserComment insert];

        userComment.idComment=@(idComment);
        userComment.username=[NSString stringWithStringDefault:[DataManager shareInstance].currentUser.name];
        userComment.comment=values[3];
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
