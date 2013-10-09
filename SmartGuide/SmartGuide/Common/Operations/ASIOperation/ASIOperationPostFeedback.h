//
//  ASIOperationPostFeedback.h
//  SmartGuide
//
//  Created by XXX on 8/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationPostFeedback : ASIOperationPost

-(ASIOperationPostFeedback*) initWithIDUser:(int) idUser content:(NSString*) content;

@property (nonatomic, readonly) bool isSuccess;

@end
