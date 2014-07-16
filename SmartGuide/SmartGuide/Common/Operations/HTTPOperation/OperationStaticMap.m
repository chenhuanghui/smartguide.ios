//
//  OperationStaticMap.m
//  Infory
//
//  Created by XXX on 7/16/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationStaticMap.h"
#import "AFURLRequestSerialization.h"

@implementation OperationStaticMap

+(NSString*) markerSize:(enum MARKER_SIZE_TYPE) type
{
    switch (type) {
        case MARKER_SIZE_TYPE_MID:
            return @"mid";
            
        case MARKER_SIZE_TYPE_SMALL:
            return @"small";
            
        case MARKER_SIZE_TYPE_TINY:
            return @"tiny";
    }
    
    return [OperationStaticMap markerSize:MARKER_SIZE_TYPE_SMALL];
}

+(NSString*) markerColor:(enum MARKER_COLOR_TYPE) type
{
    switch (type) {
        case MARKER_COLOR_TYPE_BLACK:
            return @"black";
            
        case MARKER_COLOR_TYPE_BLUE:
            return @"blue";
            
        case MARKER_COLOR_TYPE_BROWN:
            return @"brown";
            
        case MARKER_COLOR_TYPE_GRAY:
            return @"gray";
            
        case MARKER_COLOR_TYPE_GREEN:
            return @"green";
            
        case MARKER_COLOR_TYPE_ORANGE:
            return @"orange";
            
        case MARKER_COLOR_TYPE_PURPLE:
            return @"purple";
            
        case MARKER_COLOR_TYPE_RED:
            return @"red";
            
        case MARKER_COLOR_TYPE_WHITE:
            return @"white";
            
        case MARKER_COLOR_TYPE_YELLOW:
            return @"yellow";
    }
    
    return [OperationStaticMap markerColor:MARKER_COLOR_TYPE_RED];
}

-(OperationStaticMap *)initWithSize:(CGSize)size markerSizeType:(enum MARKER_SIZE_TYPE)markerSizeType markerColorType:(enum MARKER_COLOR_TYPE)markerColorType markerLocation:(CLLocationCoordinate2D)markerLocation
{
    NSString *marker=[NSString stringWithFormat:@"size:%@|color:%@|%f,%f"
                      ,[OperationStaticMap markerSize:markerSizeType]
                      ,[OperationStaticMap markerColor:markerColorType]
                      , markerLocation.latitude
                      , markerLocation.longitude];
    
    NSDictionary *dict=[NSDictionary
                        dictionaryWithObjects:@[@(15)
                                                , [NSString stringWithFormat:@"%ix%i", (int)size.width, (int)size.height]
                                                , @([UIScreen mainScreen].scale)
                                                , @"JPEG"
                                                , @"vn-vi"
                                                , marker]
                        forKeys:@[@"zoom"
                                  ,@"size"
                                  , @"scale"
                                  , @"format"
                                  , @"language"
                                  , @"markers"]];
    
    NSString *urlStaticMap=@"https://maps.googleapis.com/maps/api/staticmap";
    
    NSError *error=nil;
    
    AFHTTPRequestSerializer *requestSerializer=[AFHTTPRequestSerializer serializer];
    
    NSMutableURLRequest *request=[requestSerializer requestWithMethod:@"GET" URLString:urlStaticMap parameters:dict error:&error];
    
    self=[super initWithRequest:request];
    
    self.responseSerializer=[AFImageResponseSerializer serializer];
    
    return self;
}

-(void)onCompletedWithResponseObject:(id)responseObject error:(NSError *)error
{
    if([responseObject isKindOfClass:[UIImage class]])
    {
        self.image=responseObject;
    }
}

@end
