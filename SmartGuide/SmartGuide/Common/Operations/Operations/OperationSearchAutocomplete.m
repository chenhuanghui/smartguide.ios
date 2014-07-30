//
//  OperationSearchAutocomplete.m
//  SmartGuide
//
//  Created by MacMini on 03/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationSearchAutocomplete.h"
#define QUERY @"{\"query\":{\"filtered\":{\"query\":{\"query_string\":{\"query\":\"%@\",\"fields\":[\"shop_name_auto_complete\",\"name_auto_complete\"]}},\"filter\":{\"term\":{\"city\":%i}}}},\"highlight\":{\"fields\":{\"shop_name_auto_complete\":{},\"name_auto_complete\":{}}},\"from\":0,\"size\":5,\"fields\":[\"shop_name\",\"hasPromotion\",\"name\",\"id\"]}"

@implementation OperationSearchAutocomplete

-(OperationSearchAutocomplete *)initWithKeyword:(NSString *)keyword_ idCity:(int)idCity
{
    NSString *key=[keyword_ lowercaseString];
    
    NSString *esQuery=QUERY;
    
    NSString *query=[NSString stringWithFormat:esQuery,key,idCity];

    self=[super initGETWithRouter:URL(API_ELASTIC_AUTOCOMPLETE_NATIVE)];
    
    [self.keyValue setObject:query forKey:@"source"];
    [self.storeData setObject:key forKey:@"key"];
    
    return self;
}

-(bool)isApplySGData
{
    return false;
}

-(NSString *)keyword
{
    return [NSString makeString:self.storeData[@"key"]];
}

-(void)onFailed:(NSError *)error
{
    self.shops=[NSMutableArray new];
    self.placelists=[NSMutableArray new];
    self.highlightTag=@"em";
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.shops=[NSMutableArray new];
    self.placelists=[NSMutableArray new];
    self.highlightTag=@"em";
    
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    dict=dict[@"hits"];
    
    if([dict isNullData])
        return;
    
    NSArray *hits=dict[@"hits"];
    
    if([hits isNullData])
        return;
    
    NSArray *array=nil;
    for(NSDictionary *hit in hits)
    {
        NSDictionary *kvp=hit[@"fields"];
        
        if([kvp isNullData])
            continue;
        
        NSString *type=[NSString makeString:hit[@"_type"]];
        
        if([type isEqualToString:@"placelist"])
        {
            array=kvp[@"id"];
            
            if([array isNullData])
                continue;
            
            int idPlacelist=[[NSNumber makeNumber:array[0]] integerValue];
            
            AutocompletePlacelist *place=[AutocompletePlacelist new];
            place.idPlacelist=@(idPlacelist);
            
            array=kvp[@"name"];
            
            if([array isNullData])
                continue;
            
            place.content=[NSString makeString:array[0]];
            
            [self.placelists addObject:place];
            
            kvp=hit[@"highlight"];
            
            if([kvp isNullData])
                continue;
            
            NSArray *highlightArray=kvp[@"name_auto_complete"];
            
            if([highlightArray isNullData])
                continue;
            
            place.highlight=[NSString makeString:highlightArray[0]];
        }
        else if([type isEqualToString:@"shop"])
        {
            array=kvp[@"id"];
            
            if([array isNullData])
                continue;
            
            int idShop=[[NSNumber makeNumber:array[0]] integerValue];
            
            AutocompleteShop *shop=[AutocompleteShop new];
            shop.idShop=@(idShop);
            
            array=kvp[@"shop_name"];
            
            if([array isNullData])
                continue;
            
            shop.content=[NSString makeString:array[0]];
            
            array=kvp[@"hasPromotion"];
            
            shop.hasPromotion=@(false);
            if(![array isNullData])
                shop.hasPromotion=@([[NSNumber makeNumber:array[0]] boolValue]);
            
            [self.shops addObject:shop];
            
            kvp=hit[@"highlight"];
            
            if([kvp isNullData])
                continue;
            
            NSArray *highlightArray=kvp[@"shop_name_auto_complete"];
            
            if([highlightArray isNullData])
                continue;
            
            shop.highlight=[NSString makeString:highlightArray[0]];
        }
    }
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