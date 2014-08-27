//
//  OperationPlacelist.m
//  Infory
//
//  Created by XXX on 8/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationPlacelist.h"
#import "SearchPlacelist.h"

@implementation OperationPlacelist

-(OperationPlacelist *)initWithPage:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_PLACELIST_GET_LIST)];
    
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.placelists=[NSMutableArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    for(NSDictionary *dict in json)
    {
        SearchPlacelist *obj=[SearchPlacelist makeWithdata:dict];
        
        [self.placelists addObject:obj];
    }
    
    if(self.placelists.count>0)
        [[DataManager shareInstance] save];
}

@end
