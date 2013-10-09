//
//  ASIOperationGetAvatars.h
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationGetAvatars : ASIOperationPost

-(ASIOperationGetAvatars*) initGetAvatars;

@property (nonatomic, readonly) NSMutableArray *avatars;

@end
