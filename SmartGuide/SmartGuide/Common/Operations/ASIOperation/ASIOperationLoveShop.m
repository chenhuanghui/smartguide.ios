//
//  ASIOperationLoveShop.m
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationLoveShop.h"

@implementation ASIOperationLoveShop
@synthesize values,status,message,loveStatus,numOfLove;

+(void)loveShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    [[[ASIOperationLoveShop alloc] initWithIDShop:idShop userLat:userLat userLng:userLng isLove:true] startAsynchronous];
}

+(void)unLoveShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    [[[ASIOperationLoveShop alloc] initWithIDShop:idShop userLat:userLat userLng:userLng isLove:false] startAsynchronous];
}

-(ASIOperationLoveShop *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng isLove:(int)isLove
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_LOVE_SHOP)]];

    values=@[@(idShop),@(userLat),@(userLng),@(isLove)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"userLat",@"userLng",@"isLove"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
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
        
        int idShop=[values[0] integerValue];
        Shop *shop=[Shop shopWithIDShop:idShop];
        
        if(shop)
        {
            shop.numOfLove=numOfLove;
            shop.totalLove=[NSNumber numberWithObject:dict[@"totalLove"]];
            shop.loveStatus=@(loveS);
        }
   
        [[DataManager shareInstance] save];
    }
}

@end
