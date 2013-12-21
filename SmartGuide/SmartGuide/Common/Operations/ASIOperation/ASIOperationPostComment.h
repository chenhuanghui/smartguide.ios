//
//  ASIOperationPostComment.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class ShopUserComment;

@interface ASIOperationPostComment : ASIOperationPost
{
}

-(ASIOperationPostComment*) initWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng comment:(NSString*) comment sort:(enum SORT_SHOP_COMMENT) sort;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) int idComment;
@property (nonatomic, readonly) enum SORT_SHOP_COMMENT sortComment;
@property (nonatomic, readonly) ShopUserComment *userComment;

@end
