//
//  OperationRouterMap.m
//  SmartGuide
//
//  Created by XXX on 8/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationRouterMap.h"

@implementation OperationRouterMap

-(OperationRouterMap *)initWithSource:(CLLocationCoordinate2D)source destination:(CLLocationCoordinate2D)destination localeIdentifier:(NSString *)localeIdentifier
{
    self=[super initGETWithRouter:URL(@"http://maps.google.com/maps")];
    
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", source.latitude, source.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", destination.latitude, destination.longitude];
    
    [self.keyValue setObject:@"dragdir" forKey:@"output"];
    [self.keyValue setObject:saddr forKey:@"saddr"];
    [self.keyValue setObject:daddr forKey:@"daddr"];
    [self.keyValue setObject:localeIdentifier forKey:@"hl"];
    
    return self;
}

-(void)addToQueue
{
    [super addToQueue];
    
    self.responseSerializer=[AFHTTPResponseSerializer serializer];
}

-(bool)isApplySGData
{
    return false;
}

-(void)onFinishLoading
{
    self.steps=[NSMutableArray array];
}

-(bool)isHandleResponseString:(NSString *)resString error:(NSError *__autoreleasing *)error
{
    resString=resString?:@"";
    
    if(!([resString containsString:@"points"] && [resString containsString:@"levels"]))
        return true;
    
    NSInteger a = [resString indexOf:@"points:\"" from:0];
    NSInteger b = [resString indexOf:@"\",levels:\"" from:a] - 10;
    
    //        NSInteger c = [responseString indexOf:@"tooltipHtml:\"" from:0];
    //        NSInteger d = [responseString indexOf:@"(" from:c];
    //        NSInteger e = [responseString indexOf:@")\"" from:d] - 2;
    
    //        NSString* info = [[responseString substringFrom:d to:e] stringByReplacingOccurrencesOfString:@"\\x26#160;" withString:@""];
    
    NSString* encodedPoints = [resString substringFrom:a to:b];
    self.steps=[Utility decodePolyLine:[encodedPoints mutableCopy]];
    
    return true;
}

@end
