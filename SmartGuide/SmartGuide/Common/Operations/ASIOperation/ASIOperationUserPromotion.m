//
//  ASIOperationUserPromotion.m
//  SmartGuide
//
//  Created by MacMini on 17/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserPromotion.h"

@implementation ASIOperationUserPromotion
@synthesize userPromotions;

-(ASIOperationUserPromotion *)initWithPage:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_USER_PROMOTION)];
 
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    userPromotions=[NSMutableArray array];
    if([self isNullData:json])
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
        
        [userPromotions addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
