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

-(void)onFinishLoading
{
    homes=[NSMutableArray array];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    int count=0;
    for(NSDictionary *dict in json)
    {
        UserHome *home=[UserHome makeWithDictionary:dict];
        home.page=self.keyValue[@"page"];
        home.sortOrder=@(count++);
        
        switch (home.enumType) {
            case USER_HOME_TYPE_1:
                home.home1=[UserHome1 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_2:
            {
                [home makeHomeImage:dict[@"images"]];
            }
                break;
                
            case USER_HOME_TYPE_3:
            {
                NSArray *array=dict[@"placelists"];
                
                if([array hasData])
                {
                    int sort=0;
                    for(NSDictionary *place in array)
                    {
                        UserHome3 *home3=[UserHome3 makeWithDictionary:place];
                        home3.sortOrder=@(sort++);
                        
                        [home addHome3Object:home3];
                    }
                }
                
                [home makeHomeImage:dict[@"images"]];
            }
                break;
                
            case USER_HOME_TYPE_4:
            {
                NSArray *array=dict[@"shops"];
                
                if([array hasData])
                {
                    int sort=0;
                    for(NSDictionary *shop in array)
                    {
                        UserHome4 *home4=[UserHome4 makeWithDictionary:shop];
                        home4.sortOrder=@(sort++);
                        
                        [home addHome4Object:home4];
                    }
                }
                
                [home makeHomeImage:dict[@"images"]];
            }
                break;
                
            case USER_HOME_TYPE_6:
                home.home6=[UserHome6 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_8:
                home.home8=[UserHome8 makeWithDictionary:dict];
                break;
                
            case USER_HOME_TYPE_9:

                [home makeHomeImage:dict[@"images"]];

                home.imageHeight=[NSNumber makeNumber:dict[@"imageHeight"]];
                home.imageWidth=[NSNumber makeNumber:dict[@"imageWidth"]];
                home.title=[NSString makeString:dict[@"title"]];

                if([dict[@"idPlacelist"] hasData])
                    home.idPlacelist=[NSNumber makeNumber:dict[@"idPlacelist"]];
                else if([dict[@"idShops"] hasData])
                    home.idShops=[NSString makeString:dict[@"idShops"]];

                break;
                
            case USER_HOME_TYPE_UNKNOW:
                break;
        }
        
        [homes addObject:home];
    }
    
    if(homes.count>0)
        [[DataManager shareInstance] save];
}

@end