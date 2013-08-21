//
//  ASIOperationGroupInCity.h
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "Group.h"

@interface ASIOperationGroupInCity : ASIOperationPost

-(ASIOperationGroupInCity*) initWithIDCity:(int) idCity;

@property (nonatomic, readonly) NSArray *groups;

@end
