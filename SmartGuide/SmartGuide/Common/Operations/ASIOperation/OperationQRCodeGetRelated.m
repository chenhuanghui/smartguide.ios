//
//  OperationQRCodeGetRelated.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationQRCodeGetRelated.h"

@implementation OperationQRCodeGetRelated

-(OperationQRCodeGetRelated *)initWithCode:(NSString *)code type:(enum QRCODE_RELATED_TYPE)type page:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithRouter:SERVER_API_URL_MAKE(API_QRCODE_GET_RELATED)];
    
    [self.keyValue setObject:code forKey:@"code"];
    [self.keyValue setObject:@(type) forKey:@"type"];
    [self.keyValue setObject:@(page) forKey:@"page"];
    [self.keyValue setObject:@(5) forKey:@"pageSize"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.relaties=[NSMutableArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
}

@end