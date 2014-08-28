//
//  OperationMessageList.h
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationMessageList : ASIOperationPost

-(OperationMessageList*) initWithIDSender:(int) idSender page:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *messages;

@end
