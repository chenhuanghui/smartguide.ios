//
//  SGData.m
//  SmartGuide
//
//  Created by MacMini on 24/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGData.h"

static SGData *_sgData=nil;
@implementation SGData
@synthesize fScreen;

+(SGData *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sgData=[SGData new];
    });
    
    return _sgData;
}

-(void)setFScreen:(NSString *)_fScreen
{
    fScreen=[[NSString alloc] initWithString:_fScreen];
    self.fData=[NSMutableDictionary new];
}

@end
