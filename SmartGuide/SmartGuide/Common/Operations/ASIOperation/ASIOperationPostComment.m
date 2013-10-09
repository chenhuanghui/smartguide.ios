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
@synthesize values,isSuccess,comment;

-(ASIOperationPostComment *)initWithIDUser:(int)idUser idShop:(int)idShop content:(NSString *)content
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_POST_COMMENT)];
    
    self=[super initWithURL:_url];
    
    isSuccess=false;
    comment=nil;
    values=@[@(idUser),@(idShop),content,@(0)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"shop_id",@"content",@"share"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=[[[json objectAtIndex:0] objectForKey:@"status"] boolValue];
    
    if(isSuccess)
    {
        Shop *shop=[Shop shopWithIDShop:[[values objectAtIndex:1] integerValue]];
        comment=[ShopUserComment insert];
        comment.shop=shop;
        comment.idShop=shop.idShop;
        comment.user=[DataManager shareInstance].currentUser.name;
        comment.comment=[values objectAtIndex:2];
        comment.avatar=[NSString stringWithStringDefault:[DataManager shareInstance].currentUser.avatar];
        comment.time=[NSString stringWithStringDefault:[[json objectAtIndex:0] objectForKey:@"time"]];
        comment.fulltime=[NSString stringWithStringDefault:[[json objectAtIndex:0] objectForKey:@"fulltime"]];
        
        [[DataManager shareInstance] save];
    }
}
@end
