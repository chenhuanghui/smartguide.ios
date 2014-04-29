//
//  ASIOperationUserNotice.h
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUserNotice : ASIOperationPost

-(ASIOperationUserNotice*) initWithUserLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSString *notifce;

@end
