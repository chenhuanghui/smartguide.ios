//
//  ASIOperationPostComment.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class ShopUserComment;

@interface ASIOperationPostComment : ASIOperationPost<ASIOperationPostDelegate>
{
    void(^_onPostCompleted)(bool finished, ShopUserComment *comment);
}

+(void) postCommentWithIDUser:(int) idUser idShop:(int) idShop content:(NSString*) content onCompleted:(void(^)(bool finished, ShopUserComment *comment)) completed;
-(ASIOperationPostComment*) initWithIDUser:(int) idUser idShop:(int) idShop content:(NSString*) content;

-(void) setPostCommentComplete:(void(^)(bool finished, ShopUserComment *comment)) onPostCompleted;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) ShopUserComment *comment;

@end
