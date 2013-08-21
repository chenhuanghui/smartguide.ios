//
//  OperationVersion.m
//  SmartGuide
//
//  Created by XXX on 7/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationVersion.h"

@implementation OperationVersion
@synthesize version;

-(OperationVersion *)initWithType:(enum VERSION_TYPE)type
{
    NSURL *url=[NSURL URLWithString:SERVER_API_MAKE(API_VERSION(type))];
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    version=[NSString stringWithFormat:@"%@",[json objectAtIndex:0]];
}

@end