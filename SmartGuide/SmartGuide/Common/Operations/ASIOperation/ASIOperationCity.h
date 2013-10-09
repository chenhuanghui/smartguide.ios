//
//  ASIOperationCity.h
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class ASIOperationVersion;

@interface ASIOperationCity : ASIOperationPost<ASIOperationPostDelegate>
{
    ASIOperationVersion *version;
}

-(ASIOperationCity*) initOperationCity;

@property (nonatomic, readonly) NSArray *cities;

@end