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

-(enum SORT_SHOP_COMMENT) sortComment;

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSNumber *idComment;
@property (nonatomic, strong) ShopUserComment *userComment;

@end
