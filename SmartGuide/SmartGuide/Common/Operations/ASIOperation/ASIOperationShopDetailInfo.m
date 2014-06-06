//
//  ASIOperationShopDetailInfo.m
//  SmartGuide
//
//  Created by MacMini on 22/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopDetailInfo.h"

@implementation ASIOperationShopDetailInfo
@synthesize infos;

-(ASIOperationShopDetailInfo *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_DETAIL_INFO)]];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    infos=[NSMutableArray array];
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        InfoTypeObject *info=[InfoTypeObject infoWithDictionary:dict];
        
        if(info.type!=DETAIL_INFO_TYPE_UNKNOW)
        {
            NSArray *items=dict[@"items"];
            
            if([self isNullData:items])
                continue;
            
            switch (info.type) {
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
                    continue;
            }
            
            [infos addObject:info];
        }
    }
}

@end

@implementation InfoTypeObject
@synthesize type,header,items;

- (id)init
{
    self = [super init];
    if (self) {
        type=DETAIL_INFO_TYPE_UNKNOW;
        header=@"";
        items=[NSMutableArray array];
    }
    return self;
}

+(InfoTypeObject *)infoWithDictionary:(NSDictionary *)dict
{
    InfoTypeObject *obj = [InfoTypeObject new];
    
    obj.header=[NSString stringWithStringDefault:dict[@"header"]];
    
    int type=[[NSNumber numberWithObject:dict[@"type"]] integerValue];
    
    switch (type) {
        case 1:
            obj.type=DETAIL_INFO_TYPE_1;
            break;

        case 2:
            obj.type=DETAIL_INFO_TYPE_2;
            break;
            
        case 3:
            obj.type=DETAIL_INFO_TYPE_3;
            break;
            
        case 4:
            obj.type=DETAIL_INFO_TYPE_4;
            break;
            
        default:
            obj.type=DETAIL_INFO_TYPE_UNKNOW;
            break;
    }
    
    return obj;
}

@end

@implementation Info1
@synthesize isTicked,content;

- (id)init
{
    self = [super init];
    if (self) {
        isTicked=DETAIL_INFO_TICKED_NONE;
        content=@"";
    }
    return self;
}

+(Info1 *)infoWithDictionary:(NSDictionary *)dict
{
    Info1 *obj=[Info1 new];
    
    int isTicked=[[NSNumber numberWithObject:dict[@"isTicked"]] integerValue];
    
    switch (isTicked) {
        case 0:
            obj.isTicked=DETAIL_INFO_TICKED_NONE;
            break;
            
        case 1:
            obj.isTicked=DETAIL_INFO_TICKED;
            break;
            
        default:
            obj.isTicked=DETAIL_INFO_TICKED_NONE;
            break;
    }
    
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    
    return obj;
}

-(NSString *)content1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit,sed diam nonummy nibh euismod tincidunt ut la sed diam nonummy nibh euismod tincidunt ut la Lorem ipsum dolor sit amet, consectetuer adipiscing elit,sed diam nonummy nibh euismod tincidunt ut la sed diam nonummy nibh euismod tincidunt ut la";
}

@end

@implementation Info2
@synthesize title,content;

-(NSString *)content1
{
    return @"Lorem ipsum dolor sit amet consectetuer adipiscing elit nibh euismod tincidunt ut la sed";
}

-(NSString *)title1
{
    return @"Lorem ipsum dolor sit amet";
}

- (id)init
{
    self = [super init];
    if (self) {
        title=@"";
        content=@"";
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

@end

@implementation Info3
@synthesize content,title,image;

- (id)init
{
    self = [super init];
    if (self) {
        content=@"";
        title=@"";
        image=@"";
    }
    return self;
}

+(Info3 *)infoWithDictionary:(NSDictionary *)dict
{
    Info3 *obj=[Info3 new];
    
    obj.image=[NSString stringWithStringDefault:dict[@"image"]];
    obj.title=[NSString stringWithStringDefault:dict[@"title"]];
    obj.content=[NSString stringWithStringDefault:dict[@"content"]];
    obj.idShop=[[NSNumber numberWithObject:dict[@"idShop"]] integerValue];
    
    obj.titleHeight=@(-1);
    obj.contentHeight=@(-1);
    
    return obj;
}

-(NSString *)title1
{
    return @"";
}

-(NSString *)content1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
}

@end

@implementation Info4
@synthesize content,date,title;

- (id)init
{
    self = [super init];
    if (self) {
        content=@"";
        date=@"";
        title=@"";
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

-(NSString *)content1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit,sed diam nonummy nibh euismod tincidunt";
}

@end