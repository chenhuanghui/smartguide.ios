//
//  ASIOperationUserPromotion.m
//  SmartGuide
//
//  Created by MacMini on 17/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserPromotion.h"

@implementation ASIOperationUserPromotion

-(ASIOperationUserPromotion *)initWithPage:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_PROMOTION)];
 
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.userPromotions=[NSMutableArray array];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    int count=0;
    NSArray *array=[UserPromotion allObjects];
    
    if(array.count>0)
        count=[[array valueForKeyPath:[NSString stringWithFormat:@"@max.%@",UserPromotion_SortOrder]] integerValue]+1;
    
    for(NSDictionary *dict in json)
    {
        UserPromotion *obj =[UserPromotion makeWithDictionary:dict];

        if(obj.promotionType==USER_PROMOTION_UNKNOW)
            continue;
        
        obj.sortOrder=@(count++);
        
        [self.userPromotions addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
