//
//  OperationQRCodeGetAllRelated.m
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationQRCodeGetAllRelated.h"
#import "ScanCodeRelatedContain.h"
#import "ScanCodeRelated.h"

@implementation OperationQRCodeGetAllRelated

-(OperationQRCodeGetAllRelated *)initWithCode:(NSString*)code userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_QRCODE_GET_RELATED)];
    
    [self.keyValue setObject:code forKey:@"code"];
    [self.keyValue setObject:@(0) forKey:@"type"]; //all
    [self.keyValue setObject:@(0) forKey:@"page"];
    [self.keyValue setObject:@(5) forKey:@"pageSize"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.relatedContains=[NSMutableArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    int countContain=0;
    for(NSDictionary *dict in json)
    {
        if([dict isKindOfClass:[NSDictionary class]])
        {
            if([dict[@"relatedShops"] hasData])
            {
                NSArray *shops=dict[@"relatedShops"];
                
                ScanCodeRelatedContain *contain=[ScanCodeRelatedContain insert];
                contain.type=@(QRCODE_RELATED_TYPE_SHOPS);
                contain.order=@(countContain++);
                contain.canLoadMore=@(shops.count>=5);
                contain.page=@(0);
                
                int count=0;
                for(NSDictionary *shop in shops)
                {
                    ScanCodeRelated *obj=[ScanCodeRelated makeWithShopDictionary:shop];
                    obj.order=@(count++);
                    obj.page=@(0);
                    
                    [contain addRelatiesObject:obj];
                }
                
                [self.relatedContains addObject:contain];
            }
            else if([dict[@"relatedPromotions"] hasData])
            {
                NSArray *promotions=dict[@"relatedPromotions"];
               
                ScanCodeRelatedContain *contain=[ScanCodeRelatedContain insert];
                contain.type=@(QRCODE_RELATED_TYPE_PROMOTIONS);
                contain.order=@(countContain++);
                contain.canLoadMore=@(promotions.count>=5);
                contain.page=@(0);
                
                int count=0;
                for(NSDictionary *promotion in promotions)
                {
                    ScanCodeRelated *obj=[ScanCodeRelated makeWithPromotionDictionary:promotion];
                    obj.order=@(count++);
                    obj.page=@(0);
                    
                    [contain addRelatiesObject:obj];
                }
                
                [self.relatedContains addObject:contain];
            }
            else if([dict[@"relatedPlacelists"] hasData])
            {
                NSArray *places=dict[@"relatedPlacelists"];
               
                ScanCodeRelatedContain *contain=[ScanCodeRelatedContain insert];
                contain.type=@(QRCODE_RELATED_TYPE_PLACELISTS);
                contain.order=@(countContain++);
                contain.canLoadMore=@(places.count>=5);
                contain.page=@(0);
                
                int count=0;
                for(NSDictionary *place in places)
                {
                    ScanCodeRelated *obj=[ScanCodeRelated makeWithPlacelistDictionary:place];
                    obj.order=@(count++);
                    obj.page=@(0);
                    
                    [contain addRelatiesObject:obj];
                }
                
                [self.relatedContains addObject:contain];
            }
        }
    }
    
    if(self.relatedContains.count>0)
        [[DataManager shareInstance] save];
}

@end
