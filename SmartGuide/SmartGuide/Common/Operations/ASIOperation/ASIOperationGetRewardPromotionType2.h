//
//  ASIOperaionGetReward.h
//  SmartGuide
//
//  Created by XXX on 8/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetRewardPromotionType2 : ASIOperationPost
{
}

-(ASIOperationGetRewardPromotionType2*) initWithIDUser:(int) idUser promotionID:(int) promotionID code:(NSString*) code;

@property (nonatomic, readonly) bool status;
@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) double money;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSString *shopName;
@property (nonatomic, readonly) NSString *code;

@end
