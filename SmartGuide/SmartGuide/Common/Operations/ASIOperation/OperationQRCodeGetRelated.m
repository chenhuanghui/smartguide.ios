//
//  OperationQRCodeGetRelated.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationQRCodeGetRelated.h"
#import "ScanCodeRelated.h"

@implementation OperationQRCodeGetRelated

-(OperationQRCodeGetRelated *)initWithCode:(NSString *)code type:(enum QRCODE_RELATED_TYPE)type page:(int)page userLat:(double)userLat userLng:(double)userLng groupIndex:(int)groupIndex
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_QRCODE_GET_RELATED)];
    
    [self.keyValue setObject:code forKey:@"code"];
    [self.keyValue setObject:@(type) forKey:@"type"];
    [self.keyValue setObject:@(page) forKey:@"page"];
    [self.keyValue setObject:@(15) forKey:@"pageSize"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    [self.storeData setObject:@(groupIndex) forKey:@"groupIndex"];
    
    return self;
}

-(int)groupIndex
{
    return [self.storeData[@"groupIndex"] integerValue];
}

-(void)onFinishLoading
{
    self.relaties=[NSMutableArray new];
}

-(enum QRCODE_RELATED_TYPE)type
{
    return (enum QRCODE_RELATED_TYPE)[self.keyValue[@"type"] integerValue];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    int page=[self.keyValue[@"page"] integerValue];
    
    for(NSDictionary *dict in json)
    {
        if([dict isKindOfClass:[NSDictionary class]])
        {
            if([dict[@"relatedShops"] hasData])
            {
                NSArray *shops=dict[@"relatedShops"];
                
                NSMutableArray *array=[NSMutableArray array];
                int count=0;
                for(NSDictionary *shop in shops)
                {
                    ScanCodeRelated *obj=[ScanCodeRelated makeWithShopDictionary:shop];
                    obj.order=@(count++);
                    obj.page=@(page);
                    
                    [array addObject:obj];
                }
                
                [self.relaties addObject:array];
            }
            else if([dict[@"relatedPromotions"] hasData])
            {
                NSArray *promotions=dict[@"relatedPromotions"];
                
                NSMutableArray *array=[NSMutableArray array];
                int count=0;
                for(NSDictionary *promotion in promotions)
                {
                    ScanCodeRelated *obj=[ScanCodeRelated makeWithPromotionDictionary:promotion];
                    obj.order=@(count++);
                    obj.page=@(page);
                    
                    [array addObject:obj];
                }
                
                [self.relaties addObject:array];
            }
            else if([dict[@"relatedPlacelists"] hasData])
            {
                NSArray *places=dict[@"relatedPlacelists"];
                
                NSMutableArray *array=[NSMutableArray array];
                int count=0;
                for(NSDictionary *place in places)
                {
                    ScanCodeRelated *obj=[ScanCodeRelated makeWithPlacelistDictionary:place];
                    obj.order=@(count++);
                    obj.page=@(page);
                    
                    [array addObject:obj];
                }
                
                [self.relaties addObject:array];
            }
        }
    }
    
    if(self.relaties.count>0)
        [[DataManager shareInstance] save];
}

@end