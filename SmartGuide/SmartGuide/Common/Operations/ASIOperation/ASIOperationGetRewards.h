//
//  ASIOperationGetRewards.h
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetRewards : ASIOperationPost

-(ASIOperationGetRewards*) initGetRewards;

@property (nonatomic, readonly) NSMutableArray *rewards;

@end
