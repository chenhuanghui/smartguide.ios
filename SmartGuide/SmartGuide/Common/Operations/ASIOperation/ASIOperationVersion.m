//
//  ASIOperationVersion.m
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationVersion.h"

@implementation ASIOperationVersion
@synthesize version,values;

-(ASIOperationVersion *)initWithType:(enum VERSION_TYPE)type
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_VERSION)];
    self=[super initWithURL:_url];
    
    values=@[@(type)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"type"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    version=[NSString stringWithFormat:@"%@",[json objectAtIndex:0]];
}

@end
