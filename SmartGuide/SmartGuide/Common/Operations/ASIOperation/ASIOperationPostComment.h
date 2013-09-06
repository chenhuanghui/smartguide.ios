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

-(ASIOperationPostComment*) initWithIDUser:(int) idUser idShop:(int) idShop content:(NSString*) content;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) ShopUserComment *comment;

@end
