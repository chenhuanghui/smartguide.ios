//
//  ASIOperationVersion.h
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

enum VERSION_TYPE {
    VERSION_CITY = 1,
    VERSION_GROUP = 2,
};

@interface ASIOperationVersion : ASIOperationPost

-(ASIOperationVersion*) initWithType:(enum VERSION_TYPE) type;

@property (nonatomic, readonly) NSString* version;

@end
