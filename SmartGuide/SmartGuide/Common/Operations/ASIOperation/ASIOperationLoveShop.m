//
//  ASIOperationLoveShop.m
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationLoveShop.h"

@implementation ASIOperationLoveShop
@synthesize status,message,loveStatus,numOfLove,shop;

-(ASIOperationLoveShop *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng loveStatus:(enum LOVE_STATUS)_loveStatus
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_LOVE_SHOP)]];

    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(_loveStatus) forKey:@"isLove"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        int loveS=[[NSNumber numberWithObject:dict[@"loveStatus"]] integerValue];
        numOfLove=[NSString stringWithStringDefault:dict[@"numOfLove"]];
        
        switch (loveS) {
            case 0:
                loveStatus=LOVE_STATUS_NONE;
                break;
                
            case 1:
                loveStatus=LOVE_STATUS_LOVED;
                break;
                
            default:
                loveStatus=LOVE_STATUS_NONE;
                break;
        }
        
        int idShop=[self.keyValue[IDSHOP] integerValue];
        shop=[Shop shopWithIDShop:idShop];
        
        if(shop)
        {
            shop.numOfLove=numOfLove;
            shop.totalLove=[NSNumber numberWithObject:dict[@"totalLove"]];
            shop.loveStatus=@(loveS);
            
            [[DataManager shareInstance] save];
        }
    }
}

@end
