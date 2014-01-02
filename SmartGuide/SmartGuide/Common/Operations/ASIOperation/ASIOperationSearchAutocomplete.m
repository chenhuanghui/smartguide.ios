//
//  ASIOperationSearchAutocomplete.m
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationSearchAutocomplete.h"

@implementation ASIOperationSearchAutocomplete
@synthesize shops,placelists,values,keyword;

-(ASIOperationSearchAutocomplete *)initWithKeyword:(NSString *)_keyword userLat:(double)userLat userLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_ELASTIC_AUTOCOMPLETE)]];
    
    values=@[_keyword,@(userLat),@(userLng)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"keyword",@"userLat",@"userLng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shops=[NSMutableArray array];
    placelists=[NSMutableArray array];
    keyword=[values[0] copy];
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    NSArray *array=dict[@"shop"];
    
    if(![self isNullData:array])
        shops=[array mutableCopy];
    
    array=dict[@"placelist"];
    
    if(![self isNullData:array])
        placelists=[array mutableCopy];
}

@end
