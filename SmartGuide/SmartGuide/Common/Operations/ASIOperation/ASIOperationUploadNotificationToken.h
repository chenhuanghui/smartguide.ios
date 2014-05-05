//
//  ASIOperationUploadNotificationToken.h
//  Infory
//
//  Created by XXX on 5/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUploadNotificationToken : ASIOperationPost

-(ASIOperationUploadNotificationToken*) initWithNotificationToken:(NSString*) token uuid:(NSString*) uuid;

@end
