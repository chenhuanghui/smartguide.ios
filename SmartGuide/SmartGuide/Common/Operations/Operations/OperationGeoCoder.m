//
//  OperationGeoCoder.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationGeoCoder.h"

@implementation OperationGeoCoder

-(OperationGeoCoder *)initWithLat:(double)lat lng:(double)lng language:(enum GEOCODER_LANGUAGE)language
{
    self=[super initGETWithRouter:URL(@"http://maps.googleapis.com/maps/api/geocode/json")];
    
    [self.keyValue setObject:@"true" forKey:@"sensor"];
    
    NSLocale *locale=[NSLocale localeWithLocaleIdentifier:@"vi-vn"];
    [self.keyValue setObject:[locale objectForKey:NSLocaleLanguageCode] forKey:@"language"];
    [self.keyValue setObject:[NSString stringWithFormat:@"%f,%f", lat, lng] forKey:@"latlng"];
    
    return self;
}

-(bool)isApplySGData
{
    return false;
}

-(void)onFinishLoading
{
    self.address=[NSMutableArray array];
}

-(bool)isHandleResponseString:(NSString *)resString error:(NSError *__autoreleasing *)error
{
//    if([json isNullData])
//        return true;
//    
//    NSDictionary *dict=json[0];
//    
//    if(![dict isKindOfClass:[NSDictionary class]])
//        return;
//    
//    NSArray *result=dict[@"results"];
//    
//    if([self isNullData:result])
//        return;
//    
//    for(NSDictionary *item in result)
//    {
//        if(![item isKindOfClass:[NSDictionary class]])
//            continue;
//        
//        NSString *addressFormatted=[NSString stringWithStringDefault:item[@"formatted_address"]];
//        
//        if(addressFormatted.length>0)
//            [address addObject:addressFormatted];
//    }
    
    return true;
}

@end
