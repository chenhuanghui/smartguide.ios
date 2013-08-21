//
//  ASIOperaionShopInGroup.m
//  SmartGuide
//
//  Created by XXX on 7/28/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopInGroup.h"
#import "Shop.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"
#import "Group.h"

@implementation ASIOperationShopInGroup
@synthesize shops;

-(ASIOperationShopInGroup *)initWithIDCity:(int)idCity idUser:(int)idUser lat:(double)latitude lon:(double)longtitude page:(int)page sort:(enum SORT_BY)sort group:(Group *)group, ...
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_IN_GROUP_POST)];
    self=[super initWithURL:_url];
    
    NSString *idGroupStr=@"";
    
    va_list vaGroup;
    
    va_start(vaGroup, group);
    
    for(Group *g=group;g;g=va_arg(vaGroup, Group*))
    {
        //Group all
        if(g.idGroup.integerValue==0)
        {
            idGroupStr=@"1,2,3,4,5,6,7,8,";
            break;
        }
        else
        {
            idGroupStr=[idGroupStr stringByAppendingFormat:@"%i,",g.idGroup.integerValue];
        }
    }
    
    va_end(vaGroup);
    
    idGroupStr=[idGroupStr substringWithRange:NSMakeRange(0, idGroupStr.length-1)];
    
    _values=[[NSMutableArray alloc] initWithObjects:idGroupStr,
             [NSNumber numberWithInt:idCity],
             [NSNumber numberWithInt:idUser],
             [NSNumber numberWithDouble:latitude],
             [NSNumber numberWithDouble:longtitude],
             [NSNumber numberWithInt:page],
             [NSNumber numberWithInt:sort],nil];
    
    return self;
}

-(NSArray *)values
{
    return _values;
}

-(NSArray *)keys
{
    return @[@"group_list",@"city_id",@"user_id",@"user_lat",@"user_lng",@"page",@"sort_by"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dic in json)
    {
        Shop *shop = [Shop makeShopWithDictionaryShopInGroup:dic];
        [shops addObject:shop];
    }
    
    [[DataManager shareInstance] save];
    
}

@end