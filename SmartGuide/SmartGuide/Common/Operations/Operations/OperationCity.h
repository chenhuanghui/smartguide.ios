//
//  OperationCity.h
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"
#import "OperationVersion.h"

@interface OperationCity : OperationURL<OperationURLDelegate>
{
}

-(OperationCity*) initOperationCity;

@property (nonatomic, readonly) NSArray *cities;

@end
