//
//  ASIOperationGetFeedback.h
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetFeedback : ASIOperationPost

-(ASIOperationGetFeedback*) initFeedback;

@property (nonatomic, readonly) NSMutableArray *feedbacks;

@end
