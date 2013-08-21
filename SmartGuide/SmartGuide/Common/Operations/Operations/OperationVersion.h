//
//  OperationVersion.h
//  SmartGuide
//
//  Created by XXX on 7/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

enum VERSION_TYPE {
    VERSION_CITY = 1,
    VERSION_GROUP = 2,
    };

@interface OperationVersion : OperationURL

-(OperationVersion*) initWithType:(enum VERSION_TYPE) type;

@property (nonatomic, readonly) NSString* version;

@end