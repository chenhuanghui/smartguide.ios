//
//  ASIOperationLikeDislikeShop.m
//  SmartGuide
//
//  Created by XXX on 8/9/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationLikeDislikeShop.h"
#import "Shop.h"

@implementation ASIOperationLikeDislikeShop
@synthesize values,like,likeStatus,dislike;

-(ASIOperationLikeDislikeShop *)initWithIDShop:(int)idShop userID:(int)idUser type:(int) _likeStatus status:(int)_status
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_USER_LIKE_DISLIKE)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(idUser),@(_likeStatus),@(_status)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id",@"user_id",@"type",@"like_status"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    likeStatus=[dict integerForKey:@"like_status"];
    like=[dict integerForKey:@"like"];
    dislike=[dict integerForKey:@"dislike"];
    
    Shop *shop=[Shop shopWithIDShop:[[values objectAtIndex:0] integerValue]];
    shop.like_status=@(likeStatus);
    shop.like=@(like);
    shop.dislike=@(dislike);
    
    [[DataManager shareInstance] save];
}

@end
