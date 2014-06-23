//
//  ASIOperationUserHome.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUserHome.h"

@implementation ASIOperationUserHome
@synthesize homes;

-(ASIOperationUserHome *)initWithPage:(NSUInteger)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_HOME)]];

    [self.keyValue setObject:@(page) forKey:@"page"];
    [self.keyValue setObject:@(userLat) forKey:@"userLat"];
    [self.keyValue setObject:@(userLng) forKey:@"userLng"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    homes=[NSMutableArray array];
    
    if([json isNullData])
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
                
                if([array isNullData])
                    continue;
                
                int sort=0;
                for(NSString *image in array)
                {
                    UserHome2 *home2=[UserHome2 insert];
                    home2.image=image;
                    home2.sortOrder=@(sort++);
                    
                    [home addHome2Object:home2];
                }
            }
                break;
                
            case USER_HOME_TYPE_3:
            {
                NSArray *array=dict[@"placelists"];
                
                if([array isNullData])
                    continue;
                
                int sort=0;
                for(NSDictionary *place in array)
                {
                    UserHome3 *home3=[UserHome3 makeWithDictionary:place];
                    home3.sortOrder=@(sort++);
                    
                    [home addHome3Object:home3];
                }
            }
                break;
                
            case USER_HOME_TYPE_4:
            {
                NSArray *array=dict[@"shops"];
                
                if([array isNullData])
                    continue;
                
                int sort=0;
                for(NSDictionary *shop in array)
                {
                    UserHome4 *home4=[UserHome4 makeWithDictionary:shop];
                    home4.sortOrder=@(sort++);
                    
                    [home addHome4Object:home4];
                }
            }
                break;
                
            case USER_HOME_TYPE_6:
                home.home6=[UserHome6 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_8:
                home.home8=[UserHome8 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_9:
                // Xử lý trong [UserHome makeWithDictionary]
                break;
                
            case USER_HOME_TYPE_UNKNOW:
                break;
        }
        
        [homes addObject:home];
    }
    
    [[DataManager shareInstance] save];
}

+(void)makeTest
{
    ASIOperationUserHome *ope=[[ASIOperationUserHome alloc] initWithPage:0 userLat:userLat() userLng:userLng()];
    [ope addToQueue];
}

@end