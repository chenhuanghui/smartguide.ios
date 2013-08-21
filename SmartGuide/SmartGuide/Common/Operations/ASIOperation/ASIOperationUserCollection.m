//
//  ASIOperationUserCollecition.m
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUserCollection.h"
#import "Shop.h"

@implementation ASIOperationUserCollection
@synthesize values,userCollection,totalSP;

-(ASIOperationUserCollection *)initWithUserID:(int)IDUser lat:(double)lat lon:(double)lon page:(int)page status:(bool)status
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_USER_COLLECTION)];
    self=[super initWithURL:_url];
    
    values=@[@(IDUser),@(lat),@(lon),@(page),@(status)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"user_lat",@"user_lng",@"page",@"promotion_status"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    totalSP=0;
    userCollection=[NSArray array];
    if([self isNullData:json])
    {
        return;
    }
    
    NSDictionary *dict=[json objectAtIndex:0];
    
    totalSP=[dict integerForKey:@"score"];
    
    NSMutableArray *array=[NSMutableArray array];
    
    NSArray *collection=[dict objectForKey:@"collection"];
    
    if([self isNullData:collection])
        return;
    
    for(NSDictionary *coll in collection)
    {
        Shop *shop=[Shop makeShopWithDictionaryUserCollection:coll];
        
        [array addObject:shop.idShop];
    }
    
    [[DataManager shareInstance] save];
    
    userCollection=[Shop queryShop:[NSPredicate predicateWithFormat:@"%K IN %@",Shop_IdShop,array]];
}

@end
