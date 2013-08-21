//
//  ASIOperationLikeDislikeShop.h
//  SmartGuide
//
//  Created by XXX on 8/9/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationLikeDislikeShop : ASIOperationPost

-(ASIOperationLikeDislikeShop*) initWithIDShop:(int) idShop userID:(int) idUser type:(int) likeStatus status:(int) status;

@property (nonatomic, readonly) int likeStatus;
@property (nonatomic, readonly) int like;
@property (nonatomic, readonly) int dislike;

@end
