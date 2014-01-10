//
//  OperationSearchAutocomplete.m
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationSearchAutocomplete.h"
@implementation OperationSearchAutocomplete
@synthesize shops,placelists,keyword,highlightTag;

-(OperationSearchAutocomplete *)initWithKeyword:(NSString *)_keyword
{
    NSString *key=[_keyword lowercaseString];
    
    NSString *esQuery=@"{\"query\":{\"query_string\":{\"query\":\"%@\",\"fields\":[\"shop_name_auto_complete\",\"name_auto_complete\"]}},\"highlight\":{\"fields\":{\"shop_name_auto_complete\":{},\"name_auto_complete\":{}}},\"from\":0,\"size\":5,\"fields\":[\"shop_name\",\"name\",\"id\"]}";
    
    NSString *query=[NSString stringWithFormat:esQuery,key];
    query=[query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:query forKey:@"source"];
    
    self=[super initWithRouter:API_ELASTIC_AUTOCOMPLETE_NATIVE params:dict];
    
    keyword=[[NSString alloc] initWithString:key];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    placelists=[NSMutableArray array];
    highlightTag=@"em";
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    dict=dict[@"hits"];
    
    if([dict isNullData])
        return;
    
    NSArray *hits=dict[@"hits"];
    
    if([self isNullData:hits])
        return;
    
    for(NSDictionary *hit in hits)
    {
        NSDictionary *kvp=hit[@"fields"];
        
        if([kvp isNullData])
            continue;
        
        NSString *type=[NSString stringWithStringDefault:hit[@"_type"]];
        
        if([type isEqualToString:@"placelist"])
        {
            int idPlacelist=[[NSNumber numberWithObject:kvp[@"id"]] integerValue];
            
            if(idPlacelist==0)
                continue;
            
            AutocompletePlacelist *place=[AutocompletePlacelist new];
            place.idPlacelist=idPlacelist;
            place.content=[NSString stringWithStringDefault:kvp[@"name"]];
            
            [placelists addObject:place];
            
            kvp=hit[@"highlight"];
            
            if([kvp isNullData])
                continue;
            
            NSArray *highlightArray=kvp[@"name_auto_complete"];
            
            if([self isNullData:highlightArray])
                continue;
            
            place.highlight=[NSString stringWithStringDefault:highlightArray[0]];
        }
        else if([type isEqualToString:@"shop"])
        {
            int idShop=[[NSNumber numberWithObject:kvp[@"id"]] integerValue];
            
            if(idShop==0)
                continue;
            
            AutocompleteShop *shop=[AutocompleteShop new];
            shop.idShop=idShop;
            shop.content=[NSString stringWithStringDefault:kvp[@"shop_name"]];
            shop.hasPromotion=[[NSNumber numberWithObject:kvp[@"has_promotion"]] boolValue];
            
            [shops addObject:shop];
            
            kvp=hit[@"highlight"];
            
            if([kvp isNullData])
                continue;
            
            NSArray *highlightArray=kvp[@"shop_name_auto_complete"];
            
            if([self isNullData:highlightArray])
                continue;
            
            shop.highlight=[NSString stringWithStringDefault:highlightArray[0]];
        }
    }
}

-(id)copyWithZone:(NSZone *)zone
{
    OperationSearchAutocomplete *ope=[super copyWithZone:zone];
    
    ope.keyword=self.keyword;
    
    return ope;
}

@end

@implementation AutocompletePlacelist
@synthesize idPlacelist,content,highlight;

- (id)init
{
    self = [super init];
    if (self) {
        idPlacelist=0;
        content=@"";
        highlight=@"";
    }
    return self;
}

@end

@implementation AutocompleteShop
@synthesize idShop,content,highlight;

- (id)init
{
    self = [super init];
    if (self) {
        idShop=0;
        content=@"";
        highlight=@"";
    }
    return self;
}

@end