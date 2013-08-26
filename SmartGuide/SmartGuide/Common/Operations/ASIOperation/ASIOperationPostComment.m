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

+(void)postCommentWithIDUser:(int)idUser idShop:(int)idShop content:(NSString *)content onCompleted:(void (^)(bool, ShopUserComment *))completed
{
    ASIOperationPostComment *post=[[ASIOperationPostComment alloc] initWithIDUser:idUser idShop:idShop content:content];
    [post setPostCommentComplete:completed];
    post.delegatePost=post;
    
    [post startAsynchronous];
}

-(ASIOperationPostComment *)initWithIDUser:(int)idUser idShop:(int)idShop content:(NSString *)content
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_POST_COMMENT)];
    
    self=[super initWithURL:_url];
    
    isSuccess=false;
    comment=nil;
    values=@[@(idUser),@(idShop),content];
    
    return self;
}

-(void)setPostCommentComplete:(void (^)(bool, ShopUserComment *))onPostCompleted
{
    _onPostCompleted=[onPostCompleted copy];
}

-(NSArray *)keys
{
    return @[@"user_id",@"shop_id",@"content"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=[[json objectAtIndex:0] boolValue];
    
    if(isSuccess)
    {
        Shop *shop=[Shop shopWithIDShop:[[values objectAtIndex:1] integerValue]];
        comment=[ShopUserComment insert];
        comment.shop=shop;
        comment.idShop=shop.idShop;
        comment.user=[DataManager shareInstance].currentUser.name;
        comment.comment=[values objectAtIndex:2];
        comment.avatar=[NSString stringWithStringDefault:[DataManager shareInstance].currentUser.avatar];
        
        [[DataManager shareInstance] save];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationPostComment *cmt=(ASIOperationPostComment*)operation;

    _onPostCompleted(cmt.isSuccess,cmt.comment);
    _onPostCompleted=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _onPostCompleted(false,nil);
    _onPostCompleted=nil;
}

@end
