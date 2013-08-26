//
//  ASIOperationSGToReward.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationSGToReward : ASIOperationPost

-(ASIOperationSGToReward*) initWithIDReward:(int) rewardID idUser:(int) idUser;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) NSString *content;
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSString *reward;

@end
