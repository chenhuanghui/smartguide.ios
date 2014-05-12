//
//  OperationSearchAutocomplete.m
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationSearchAutocomplete.h"
@implementation OperationSearchAutocomplete

-(OperationSearchAutocomplete *)initWithKeyword:(NSString *)keyword_
{
    NSString *key=[keyword_ lowercaseString];
    
    NSString *esQuery=@"{\"query\":{\"query_string\":{\"query\":\"%@\",\"fields\":[\"shop_name_auto_complete\",\"name_auto_complete\"]}},\"highlight\":{\"fields\":{\"shop_name_auto_complete\":{},\"name_auto_complete\":{}}},\"from\":0,\"size\":5,\"fields\":[\"shop_name\",\"hasPromotion\",\"name\",\"id\"]}";
    
    NSString *query=[NSString stringWithFormat:esQuery,key];
    query=[query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:query forKey:@"source"];
    
    self=[super initWithRouter:API_ELASTIC_AUTOCOMPLETE_NATIVE params:dict];
    
    self.keyword=[[NSString alloc] initWithString:key];
    self.shops=[NSMutableArray new];
    self.placelists=[NSMutableArray new];
    self.highlightTag=@"em";
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.shops=[NSMutableArray new];
    self.placelists=[NSMutableArray new];
    self.highlightTag=@"em";
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    dict=dict[@"hits"];
    
    if([dict isNullData])
        return;
    
    NSArray *hits=dict[@"hits"];
    
    if([self isNullData:hits])
        return;
    
    NSArray *array=nil;
    for(NSDictionary *hit in hits)
    {
        NSDictionary *kvp=hit[@"fields"];
        
        if([kvp isNullData])
            continue;
        
        NSString *type=[NSString stringWithStringDefault:hit[@"_type"]];
        
        if([type isEqualToString:@"placelist"])
        {
            array=kvp[@"id"];
            
            if([array isNullData])
                continue;
            
            int idPlacelist=[[NSNumber numberWithObject:array[0]] integerValue];
            
            AutocompletePlacelist *place=[AutocompletePlacelist new];
            place.idPlacelist=@(idPlacelist);
            
            array=kvp[@"name"];
            
            if([array isNullData])
                continue;
            
            place.content=[NSString stringWithStringDefault:array[0]];
            
            [self.placelists addObject:place];
            
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
            array=kvp[@"id"];
            
            if([array isNullData])
                continue;
            
            int idShop=[[NSNumber numberWithObject:array[0]] integerValue];
            
            AutocompleteShop *shop=[AutocompleteShop new];
            shop.idShop=@(idShop);
            
            array=kvp[@"shop_name"];
            
            if([array isNullData])
                continue;
            
            shop.content=[NSString stringWithStringDefault:array[0]];
            
            array=kvp[@"hasPromotion"];
            
            shop.hasPromotion=@(false);
            if(![array isNullData])
                shop.hasPromotion=@([[NSNumber numberWithObject:array[0]] boolValue]);
            
            [self.shops addObject:shop];
            
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