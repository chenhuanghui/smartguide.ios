//
//  OperationHome.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationHome.h"
#import "Home.h"

@implementation OperationHome

-(OperationHome *)initWithPage:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_HOME)];
    
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.homes=[NSMutableArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    for(NSDictionary *dict in json)
    {
        Home *home=[Home makeHomeWithData:dict];
        
        [self.homes addObject:home];
    }
    
    if(self.homes.count>0)
        [[DataManager shareInstance] save];
}

@end
