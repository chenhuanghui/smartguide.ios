//
//  OperationGroup.h
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@interface OperationGroupInCity : OperationURL

-(OperationGroupInCity*) initWithIDCity:(int) idCity;

@property (nonatomic, readonly) NSArray *groups;

@end