//
//  OperationGeoCoder.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGeoCoder.h"

@implementation OperationGeoCoder
@synthesize address;

-(OperationGeoCoder *)initWithLat:(double)lat lng:(double)lng language:(enum GEOCODER_LANGUAGE)language
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://maps.googleapis.com/maps/api/geocode/json"]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"%f,%f", lat, lng], @"latlng", nil];
    
    [parameters setValue:@"true" forKey:@"sensor"];
    
    switch (language) {
        case GEOCODER_LANGUAGE_VN:
        {
            NSLocale *locale=[NSLocale localeWithLocaleIdentifier:@"vi-vn"];
            [parameters setValue:[locale objectForKey:NSLocaleLanguageCode] forKey:@"language"];
        }
            break;
            
        default:
            break;
    }
    NSMutableArray *paramStringsArray = [NSMutableArray arrayWithCapacity:[[parameters allKeys] count]];
    
    for(NSString *key in [parameters allKeys]) {
        NSObject *paramValue = [parameters valueForKey:key];
        [paramStringsArray addObject:[NSString stringWithFormat:@"%@=%@", key, paramValue]];
    }
    
    NSString *paramsString = [paramStringsArray componentsJoinedByString:@"&"];
    NSString *baseAddress = request.URL.absoluteString;
    baseAddress = [baseAddress stringByAppendingFormat:@"?%@", paramsString];
    [request setURL:[NSURL URLWithString:baseAddress]];
    
    self=[super initWithRequest:request];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    address=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    if(![dict isKindOfClass:[NSDictionary class]])
        return;
    
    NSArray *result=dict[@"results"];
    
    if([self isNullData:result])
        return;
    
    for(NSDictionary *item in result)
    {
        if(![item isKindOfClass:[NSDictionary class]])
            continue;
        
        NSString *addressFormatted=[NSString stringWithStringDefault:item[@"formatted_address"]];
        
        if(addressFormatted.length>0)
            [address addObject:addressFormatted];
    }
}

@end
