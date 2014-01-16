//
//  OperationRouterMap.m
//  SmartGuide
//
//  Created by XXX on 8/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationRouterMap.h"

@implementation OperationRouterMap
@synthesize steps;

-(OperationRouterMap *)initWithSource:(CLLocationCoordinate2D)source destination:(CLLocationCoordinate2D)destination localeIdentifier:(NSString *)localeIdentifier
{
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", source.latitude, source.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", destination.latitude, destination.longitude];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"dragdir" forKey:@"output"];
    [dict setObject:saddr forKey:@"saddr"];
    [dict setObject:daddr forKey:@"daddr"];
    [dict setObject:localeIdentifier forKey:@"hl"];
    
    self=[super initWithRouter:@"http://maps.google.com/maps" params:dict];
    
    return self;
}

-(bool)canManualHandleData:(id)responseObject
{
    return true;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    steps=[NSMutableArray array];
    
    NSData* data = [json objectAtIndex:0];
    NSString* responseString = [[NSString alloc] initWithData:data encoding:self.responseStringEncoding];
    
    if(!responseString || responseString.length==0)
    {
        responseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    if(!responseString)
        responseString=@"";
    
    // TODO: better parsing. Regular expression?
    
    if(!([responseString containsString:@"points"] && [responseString containsString:@"levels"]))
        return;
    
    NSInteger a = [responseString indexOf:@"points:\"" from:0];
    NSInteger b = [responseString indexOf:@"\",levels:\"" from:a] - 10;
    
    //        NSInteger c = [responseString indexOf:@"tooltipHtml:\"" from:0];
    //        NSInteger d = [responseString indexOf:@"(" from:c];
    //        NSInteger e = [responseString indexOf:@")\"" from:d] - 2;
    
    //        NSString* info = [[responseString substringFrom:d to:e] stringByReplacingOccurrencesOfString:@"\\x26#160;" withString:@""];
    
    NSString* encodedPoints = [responseString substringFrom:a to:b];
    steps=[Utility decodePolyLine:[encodedPoints mutableCopy]];
}

@end
