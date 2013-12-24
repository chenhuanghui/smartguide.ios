//
//  ASIOperationUserHome.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUserHome.h"

@implementation ASIOperationUserHome
@synthesize values,homes;

-(ASIOperationUserHome *)initWithPage:(NSUInteger)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_HOME)]];

    values=@[@(page),@(userLat),@(userLng)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"page",@"userLat",@"userLng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    homes=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        UserHome *home=[UserHome makeWithDictionary:dict];
        
        switch (home.enumType) {
            case USER_HOME_TYPE_1:
                home.home1=[UserHome1 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_2:
            {
                NSArray *array=dict[@"images"];
                
                if([self isNullData:array])
                    continue;
                
                for(NSString *image in array)
                {
                    UserHome2 *home2=[UserHome2 insert];
                    home2.image=image;
                    
                    [home addHome2Object:home2];
                }
            }
                break;
                
            case USER_HOME_TYPE_3:
            {
                NSArray *array=dict[@"placelists"];
                
                if([self isNullData:array])
                    continue;
                
                for(NSDictionary *place in array)
                {
                    UserHome3 *home3=[UserHome3 makeWithDictionary:place];
                    
                    [home addHome3Object:home3];
                }
            }
                break;
                
            case USER_HOME_TYPE_4:
            {
                NSArray *array=dict[@"shops"];
                
                if([self isNullData:array])
                    continue;
                
                for(NSDictionary *shop in array)
                {
                    UserHome4 *home3=[UserHome4 makeWithDictionary:shop];
                    
                    [home addHome4Object:home3];
                }
            }
                break;
                
            case USER_HOME_TYPE_5:
            {
                NSArray *array=dict[@"stores"];
                
                if([self isNullData:array])
                    continue;
                
                for(NSDictionary *store in array)
                {
                    UserHome5 *home3=[UserHome5 makeWithDictionary:store];
                    
                    [home addHome5Object:home3];
                }
            }
                break;
                
            case USER_HOME_TYPE_6:
                home.home6=[UserHome6 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_7:
                home.home7=[UserHome7 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_UNKNOW:
                break;
        }
        
        [homes addObject:home];
    }
    
    [[DataManager shareInstance] save];
}

@end
