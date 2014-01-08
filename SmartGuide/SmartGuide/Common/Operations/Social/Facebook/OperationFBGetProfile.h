//
//  OperationFBGetProfile.h
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationURL.h"

@class FBProfile;

@interface OperationFBGetProfile : OperationURL
{
    NSString *_accessToken;
}

-(OperationFBGetProfile*) initWithAccessToken:(NSString*) accessToken;

@property (nonatomic, readonly) NSString *jsonData;

@end