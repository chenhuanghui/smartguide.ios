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
    }
}
@end
