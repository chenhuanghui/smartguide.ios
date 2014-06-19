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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numOfNotification=@"...";
        self.totalNotification=@(0);
        self.isShowedNotice=@(false);
        self.userNotice=@"";
        
#if DEBUG
        self.buildMode=@([[NSUserDefaults standardUserDefaults] integerForKey:@"buildMode"]);
#else
        self.buildMode=@(1);
#endif
    }
    return self;
}

-(void)setFScreen:(NSString *)_fScreen
{
    fScreen=[[NSString alloc] initWithString:_fScreen];
    self.fData=[NSMutableDictionary new];
}

#if DEBUG

-(NSString *)serverAPI
{
    switch (self.buildMode.integerValue) {
        case 1:
            return @"https://api.infory.vn/api";
            
        default:
            return @"http://dev.infory.vn/api";
    }
}

-(NSString *)serverIP
{
    switch (self.buildMode.integerValue) {
        case 1:
            return @"https://api.infory.vn";
            
        default:
            return @"http://dev.infory.vn";
    }
    
}

-(NSString *)elasticAPI
{
    return @"http://api.infory.vn:9200/data/_search";
}

#else

-(NSNumber *)buildMode
{
    return @(1);
}

-(NSString *)serverAPI
{
    return @"https://api.infory.vn/api";
}

-(NSString *)serverIP
{
    return @"https://api.infory.vn";
}

-(NSString *)elasticAPI
{
    return @"http://api.infory.vn:9200/data/_search";
}

#endif

-(NSString *)clientID
{
    return @"1_orazuv2dl3k8ossssg8804o4kwksw8kwcskkk404w40gwcwws";
}

-(NSString *)secrectID
{
    return @"4xvgf3r9dxs8k8g8o8k0gss0s0wc8so4g4wg40c8s44kgcwsks";
}

@end
