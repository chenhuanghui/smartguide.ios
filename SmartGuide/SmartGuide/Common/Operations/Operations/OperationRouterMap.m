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
    
	NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@&hl=%@", saddr, daddr, localeIdentifier];
    
    self=[super initWithURL:[NSURL URLWithString:urlString]];
    
    return self;
}

-(bool)canManualHandleData:(id)responseObject
{
    return true;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSData* data = [json objectAtIndex:0];
    NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // TODO: better parsing. Regular expression?
    
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
