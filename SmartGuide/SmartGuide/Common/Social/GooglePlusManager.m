//
//  GooglePlusManager.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "GooglePlusManager.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

static GooglePlusManager *_gpManager=nil;
@implementation GooglePlusManager
@synthesize authentication;

+(GooglePlusManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gpManager=[GooglePlusManager new];
    });
    
    return _gpManager;
}

@end
