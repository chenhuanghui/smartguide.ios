//
//  OperationQRCodeDecode.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationQRCodeDecode.h"
#import "ScanCodeDecode.h"

@implementation OperationQRCodeDecode

-(OperationQRCodeDecode *)initWithCode:(NSString *)code userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_QRCODE_DECODE)];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:code forKey:@"code"];
    
    return self;
}

-(void)onFinishLoading
{
    self.decodes=[NSMutableArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    int count=0;
    for(NSDictionary *dict in json)
    {
        if([dict isKindOfClass:[NSDictionary class]])
        {
            ScanCodeDecode *obj=[ScanCodeDecode makeWithDictionary:dict];
            
            obj.order=@(count++);
            
            [self.decodes addObject:obj];
        }
    }
    
    [[DataManager shareInstance] save];
}

@end