//
//  ASIOperationShopDetailInfo.m
//  SmartGuide
//
//  Created by MacMini on 22/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopDetailInfo.h"

@implementation ASIOperationShopDetailInfo

-(ASIOperationShopDetailInfo *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_DETAIL_INFO)]];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.infos=[NSMutableArray array];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    for(NSDictionary *dict in json)
    {
        InfoTypeObject *info=[InfoTypeObject infoWithDictionary:dict];
        
        NSArray *items=dict[@"items"];
        
        if([items isNullData])
            continue;
        
        switch (info.enumType) {
            case DETAIL_INFO_TYPE_1:
                for(NSDictionary *item in items)
                {
                    [info.items addObject:[Info1 infoWithDictionary:item]];
                }
                break;
                
            case DETAIL_INFO_TYPE_2:
                for(NSDictionary *item in items)
                {
                    [info.items addObject:[Info2 infoWithDictionary:item]];
                }
                break;
                
            case DETAIL_INFO_TYPE_3:
                for(NSDictionary *item in items)
                {
                    [info.items addObject:[Info3 infoWithDictionary:item]];
                }
                break;
                
            case DETAIL_INFO_TYPE_4:
                for(NSDictionary *item in items)
                {
                    [info.items addObject:[Info4 infoWithDictionary:item]];
                }
                break;
                
            case DETAIL_INFO_TYPE_UNKNOW:
                break;
        }
        
        [self.infos addObject:info];
    }
}

@end

@implementation InfoTypeObject

- (id)init
{
    self = [super init];
    if (self) {
        self.type=DETAIL_INFO_TYPE_UNKNOW;
        self.header=@"";
        self.items=[NSMutableArray array];
    }
    return self;
}

-(enum DETAIL_INFO_TYPE)enumType
{
    switch ((enum DETAIL_INFO_TYPE)self.type.integerValue) {
        case DETAIL_INFO_TYPE_1:
            return DETAIL_INFO_TYPE_1;
            
        case DETAIL_INFO_TYPE_2:
            return DETAIL_INFO_TYPE_2;
            
        case DETAIL_INFO_TYPE_3:
            return DETAIL_INFO_TYPE_3;
            
        case DETAIL_INFO_TYPE_4:
            return DETAIL_INFO_TYPE_4;
            
        case DETAIL_INFO_TYPE_UNKNOW:
            return DETAIL_INFO_TYPE_UNKNOW;
    }
    
    return DETAIL_INFO_TYPE_UNKNOW;
}

+(InfoTypeObject *)infoWithDictionary:(NSDictionary *)dict
{
    InfoTypeObject *obj = [InfoTypeObject new];
    
    obj.header=[NSString stringWithStringDefault:dict[@"header"]];
    obj.type=[NSNumber numberWithObject:dict[@"type"]];
    
    return obj;
}

@end

@implementation Info1

- (id)init
{
    self = [super init];
    if (self) {
        self.ticked=@(DETAIL_INFO_TICKED_NONE);
        self.content=@"";
        self.contentHeight=@(-1);
    }
    return self;
}

-(enum DETAIL_INFO_IS_TICKED)enumTickedType
{
    switch (self.ticked.integerValue) {
        case DETAIL_INFO_TICKED_NONE:
            return DETAIL_INFO_TICKED_NONE;
            
        case DETAIL_INFO_TICKED:
            return DETAIL_INFO_TICKED;
    }
    
    return DETAIL_INFO_TICKED_NONE;
}

+(Info1 *)infoWithDictionary:(NSDictionary *)dict
{
    Info1 *obj=[Info1 new];
    
    obj.ticked=[NSNumber numberWithObject:dict[@"isTicked"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return obj;
}

@end

@implementation Info2

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"";
        self.content=@"";
        self.contentHeight=@(-1);
    }
    return self;
}

+(Info2 *)infoWithDictionary:(NSDictionary *)dict
{
    Info2 *obj=[Info2 new];
    
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return obj;
}

-(enum INFO2_CONTENT_TYPE)contentType
{
    if([self.content startsWithStrings:@"http://", @"https://", @"www.", nil])
    {
        if([self.content containsString:@"facebook.com"])
        {
            return INFO2_CONTENT_TYPE_URL_FACEBOOK;
        }
        
        return INFO2_CONTENT_TYPE_URL;
    }
    
    return INFO2_CONTENT_TYPE_TEXT;
}

@end

@implementation Info3

- (id)init
{
    self = [super init];
    if (self) {
        self.content=@"";
        self.title=@"";
        self.image=@"";
        self.contentHeight=@(-1);
        self.titleHeight=@(-1);
    }
    return self;
}

+(Info3 *)infoWithDictionary:(NSDictionary *)dict
{
    Info3 *obj=[Info3 new];
    
    obj.image=[NSString stringWithStringDefault:dict[@"image"]];
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    obj.idShop=[NSNumber numberWithObject:dict[@"idShop"]];
    
    return obj;
}

@end

@implementation Info4

- (id)init
{
    self = [super init];
    if (self) {
        self.content=@"";
        self.date=@"";
        self.title=@"";
        self.contentHeight=@(-1);
        self.titleHeight=@(-1);
    }
    return self;
}

+(Info4 *)infoWithDictionary:(NSDictionary *)dict
{
    Info4 *obj=[Info4 new];
    
    obj.date=[NSString stringWithStringDefault:dict[@"date"]];
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return obj;
}

@end